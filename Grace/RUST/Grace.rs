static SRC: [&str; 35] = [
    "static SRC: [&str; 35] = [",
    "];",
    "",
    "macro_rules! format_as_bytes {",
    "    ($fmt:literal, $($all_exprs:expr),*) => {",
    "        format!($fmt, $($all_exprs),*).as_bytes()",
    "    }",
    "}",
    "",
    "/* Hey! Loook at me, I am a comment! */",
    "macro_rules! print_iterator {",
    "    ($file:ident, $str_iter:ident, $lq:expr, $rq:expr) => {",
    "        for line in $str_iter {",
    "            $file.write_all(format_as_bytes!(\"{}{}{}\\n\", $lq, line, $rq))?;",
    "        }",
    "    }",
    "}",
    "macro_rules! start_program {",
    "    () => {",
    "        use std::fs::File;",
    "        use std::io::prelude::*;",
    "        ",
    "        fn main() -> std::io::Result<()> {",
    "            let mut file = File::create(\"Grace_kid.rs\")?;",
    "            let quoted = SRC.iter().map(|s| s.escape_debug().to_string());",
    "            let mut raw = SRC.iter().map(|s| String::from(*s));",
    "            file.write_all(format_as_bytes!(\"{}\\n\", raw.next().unwrap()))?;",
    "            print_iterator!(file, quoted, \"    \\\"\", \"\\\",\");",
    "            print_iterator!(file, raw, \"\", \"\");",
    "            Ok(())",
    "        }",
    "    }",
    "}",
    "",
    "start_program!();",
];

macro_rules! format_as_bytes {
    ($fmt:literal, $($all_exprs:expr),*) => {
        format!($fmt, $($all_exprs),*).as_bytes()
    }
}

/* Hey! Loook at me, I am a comment! */
macro_rules! print_iterator {
    ($file:ident, $str_iter:ident, $lq:expr, $rq:expr) => {
        for line in $str_iter {
            $file.write_all(format_as_bytes!("{}{}{}\n", $lq, line, $rq))?;
        }
    }
}
macro_rules! start_program {
    () => {
        use std::fs::File;
        use std::io::prelude::*;
        
        fn main() -> std::io::Result<()> {
            let mut file = File::create("Grace_kid.rs")?;
            let quoted = SRC.iter().map(|s| s.escape_debug().to_string());
            let mut raw = SRC.iter().map(|s| String::from(*s));
            file.write_all(format_as_bytes!("{}\n", raw.next().unwrap()))?;
            print_iterator!(file, quoted, "    \"", "\",");
            print_iterator!(file, raw, "", "");
            Ok(())
        }
    }
}

start_program!();
