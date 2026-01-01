def join-table-row [wrap_me_sir: list] {
	$wrap_me_sir
    | str join "], ["
    | str replace --regex "^" "[" 
    | str replace --regex "$" "],"
}


def get-table-body [my_lovely_table: table] {
    let rows = $my_lovely_table 
        | each { |it| values
        | str join "], ["
        | str replace --regex "^" "["
        | str replace --regex "$" "],"
        }
    return ($rows | to text)
}

export def "to typst" [arg_input?: table] {
    let $input = $in

    let $not_null_input = match [$arg_input $input] {
        [null null] => { return "error: no input" }
        [$x null]   => { $x }
        [null $x]   => { $x }
        _           => { return "error: too much input" }
    }

    let header_text = join-table-row ($not_null_input | columns)

    let num_cols = $not_null_input | columns | length

    let prelim = $"#table\(\ncolumns: ($num_cols),"

    let table_body = get-table-body $not_null_input

    let output = [ $prelim, $header_text, $table_body, ")\n" ] 
    | str join "\n"
    $output

}

