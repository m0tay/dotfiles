from bs4 import BeautifulSoup
import csv

# Passo 1: Ler o arquivo HTML contendo a tabela
with open("tabela.html", "r", encoding="utf-8") as f:
    html_content = f.read()

# Passo 2: Criar objeto BeautifulSoup para parsear o HTML
soup = BeautifulSoup(html_content, "html.parser")

# Passo 3: Abrir arquivo CSV para escrita
with open("saida.csv", "w", newline="", encoding="utf-8") as csvfile:
    # Configura o writer para usar ; como separador e colocar aspas em tudo
    writer = csv.writer(csvfile, delimiter=";", quoting=csv.QUOTE_ALL)

    # Passo 4: Iterar em cada linha <tr> da tabela
    for tr in soup.find_all("tr"):
        tds = tr.find_all("td")
        if len(tds) != 2:
            continue  # Pula linhas que não têm 2 colunas

        # Passo 5: Extrair a tag <img> do primeiro <td>
        img_tag = tds[0].find("img")
        if not img_tag:
            continue  # Pula linhas sem imagem

        # Passo 6: Corrigir o src da imagem para URL completa
        src_original = img_tag.get("src", "")
        src_completo = "https://www.bomcondutor.pt" + src_original
        img_tag["src"] = src_completo

        # Passo 7: Converter a tag img para string e trocar aspas " por '
        img_html = str(img_tag).replace('"', "'")

        # Passo 8: Pegar conteúdo do segundo <td> com as tags HTML internas
        texto_html = tds[1].decode_contents(formatter="html").strip()

        # Passo 9: Escrever linha no CSV: imagem e texto
        writer.writerow([img_html, texto_html])
