macro_rules! src_macro { () => { static SRC: [&str; 43] = [
    "macro_rules! src_macro { () => { static SRC: [&str; 43] = [",
    "];}}",
    "",
    "macro_rules! format_as_bytes {",
    "    ($fmt:literal, $($all_exprs:expr),*) => {",
    "        format!($fmt, $($all_exprs),*).as_bytes()",
    "    }",
    "}",
    "",
    "/*",
    "    Hey! Loook at me, I am a comment!",
    "*/",
    "macro_rules! start_program {",
    "    () => {",
    "        src_macro!();",
    "        use std::fs::File;",
    "        use std::io::prelude::*;",
    "",
    "        fn print_iterator<T: Iterator<Item = String>>(",
    "            file: &mut File,",
    "            striter: T,",
    "            lq: &str,",
    "            rq: &str",
    "        ) -> std::io::Result<()> {",
    "            for line in striter {",
    "                file.write_all(format_as_bytes!(\"{}{}{}\\n\", lq, line, rq))?;",
    "            }",
    "            Ok(())",
    "        }",
    "",
    "        fn main() -> std::io::Result<()> {",
    "            let mut file = File::create(\"Grace_kid.rs\")?;",
    "            let quoted = SRC.iter().map(|s| s.escape_debug().to_string());",
    "            let mut raw = SRC.iter().map(|s| String::from(*s));",
    "            file.write_all(format_as_bytes!(\"{}\\n\", raw.next().unwrap()))?;",
    "            print_iterator(&mut file, quoted, \"    \\\"\", \"\\\",\")?;",
    "            print_iterator(&mut file, raw, \"\", \"\")?;",
    "            Ok(())",
    "        }",
    "    }",
    "}",
    "",
    "start_program!();",
];}}

macro_rules! format_as_bytes {
    ($fmt:literal, $($all_exprs:expr),*) => {
        format!($fmt, $($all_exprs),*).as_bytes()
    }
}

/*
    Hey! Loook at me, I am a comment!
*/
macro_rules! start_program {
    () => {
        src_macro!();
        use std::fs::File;
        use std::io::prelude::*;

        fn print_iterator<T: Iterator<Item = String>>(
            file: &mut File,
            striter: T,
            lq: &str,
            rq: &str
        ) -> std::io::Result<()> {
            for line in striter {
                file.write_all(format_as_bytes!("{}{}{}\n", lq, line, rq))?;
            }
            Ok(())
        }

        fn main() -> std::io::Result<()> {
            let mut file = File::create("Grace_kid.rs")?;
            let quoted = SRC.iter().map(|s| s.escape_debug().to_string());
            let mut raw = SRC.iter().map(|s| String::from(*s));
            file.write_all(format_as_bytes!("{}\n", raw.next().unwrap()))?;
            print_iterator(&mut file, quoted, "    \"", "\",")?;
            print_iterator(&mut file, raw, "", "")?;
            Ok(())
        }
    }
}

start_program!();
