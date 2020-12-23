static SRC: [&str; 16] = [
    "static SRC: [&str; 16] = [",
    "];",
    "",
    "fn print_iterator<T: Iterator<Item = String>>(striter: T, lq: &str, rq: &str) {",
    "    for line in striter {",
    "        println!(\"{}{}{}\", lq, line, rq);",
    "    }",
    "}",
    "",
    "fn main() {",
    "    let quoted_src_iter = SRC.iter().map(|s| s.escape_debug().to_string());",
    "    let mut raw_src_iter = SRC.iter().map(|s| String::from(*s));",
    "    println!(\"{}\", raw_src_iter.next().unwrap());",
    "    print_iterator(quoted_src_iter, \"    \\\"\", \"\\\",\");",
    "    print_iterator(raw_src_iter, \"\", \"\");",
    "}",
];

fn print_iterator<T: Iterator<Item = String>>(striter: T, lq: &str, rq: &str) {
    for line in striter {
        println!("{}{}{}", lq, line, rq);
    }
}

fn main() {
    let quoted_src_iter = SRC.iter().map(|s| s.escape_debug().to_string());
    let mut raw_src_iter = SRC.iter().map(|s| String::from(*s));
    println!("{}", raw_src_iter.next().unwrap());
    print_iterator(quoted_src_iter, "    \"", "\",");
    print_iterator(raw_src_iter, "", "");
}
