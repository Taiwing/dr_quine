static SRC: [&str; 14] = [
    "static SRC: [&str; 14] = [",
    "];",
    "",
    "fn main() {",
    "    let mut src_iter = SRC.iter();",
    "    let quoted_src_iter = SRC.iter().map(|s| s.escape_debug());",
    "    println!(\"{}\", src_iter.next().unwrap());",
    "    for line in quoted_src_iter {",
    "        println!(\"    \\\"{}\\\",\", line);",
    "    }",
    "    for line in src_iter {",
    "        println!(\"{}\", line);",
    "    }",
    "}",
];

fn main() {
    let mut src_iter = SRC.iter();
    let quoted_src_iter = SRC.iter().map(|s| s.escape_debug());
    println!("{}", src_iter.next().unwrap());
    for line in quoted_src_iter {
        println!("    \"{}\",", line);
    }
    for line in src_iter {
        println!("{}", line);
    }
}
