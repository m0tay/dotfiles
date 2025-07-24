BEGIN {
  RS="</tr>"      # Registra cada bloco até fechar o </tr> (ou seja, uma linha por tr)
  FS="\n"
  OFS=";"
  print "\"<img/>\";\"(text)\"" # cabeçalho (opcional)
}

# Para cada registro (linha de bloco <tr>...</tr>)
{
  # Extrair o primeiro <td>...</td>
  if (match($0, /<td>[^<]*<img[^>]*><\/td>/)) {
    img_td = substr($0, RSTART, RLENGTH)
  } else if (match($0, /<td>.*?<img[^>]*>.*?<\/td>/)) {
    img_td = substr($0, RSTART, RLENGTH)
  } else {
    img_td = ""
  }

  # Extrair o segundo <td>...</td> (o conteúdo de texto)
  # Match simplificado: pega o primeiro <td> (já pego) e o segundo <td>
  # Para pegar o segundo <td>, vamos extrair tudo entre o fechamento do primeiro <td> e o fechamento do </tr>
  # Simplesmente, podemos usar uma regex para pegar o segundo <td>...</td>
  if (match($0, /<td>.*<\/td>[[:space:]\n]*<td>(.|[\n])*<\/td>/)) {
    second_td = substr($0, RSTART, RLENGTH)
    # extrair só a segunda td:
    if (match(second_td, /<td>(.|[\n])*<\/td>/)) {
      texto_td = substr(second_td, RSTART, RLENGTH)
    } else {
      texto_td = ""
    }
  } else {
    texto_td = ""
  }

  # Extrair só a tag <img ...> da primeira td
  if (match(img_td, /<img[^>]*>/)) {
    img_tag = substr(img_td, RSTART, RLENGTH)
  } else {
    img_tag = ""
  }

  # Extrair conteúdo interno do segundo td (tirar as tags <td> e </td>)
  gsub(/^<td>/, "", texto_td)
  gsub(/<\/td>$/, "", texto_td)
  gsub(/[\n\r]+/, " ", texto_td) # transformar quebras em espaços
  gsub(/^[ \t]+|[ \t]+$/, "", texto_td) # trim espaços

  # Escapar aspas duplas internas para o CSV
  gsub(/"/, "\"\"", img_tag)
  gsub(/"/, "\"\"", texto_td)

  # Imprimir CSV
  if (img_tag != "" && texto_td != "") {
    print "\"" img_tag "\";\"" texto_td "\""
  }
}

