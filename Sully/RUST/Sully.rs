static I: i32 = 5;
static SRC: [&str; 56] = [
    "static SRC: [&str; 56] = [",
    "];",
    "",
    "macro_rules! start_program {",
    "    () => {",
    "        fn main() -> std::io::Result<()> { not_a_main()?; Ok(()) }",
    "    }",
    "}",
    "",
    "macro_rules! format_as_bytes {",
    "    ($fmt:literal, $($all_exprs:expr),*) => {",
    "        format!($fmt, $($all_exprs),*).as_bytes()",
    "    }",
    "}",
    "",
    "macro_rules! print_iterator {",
    "    ($file:ident, $str_iter:ident, $lq:expr, $rq:expr) => {",
    "        for line in $str_iter {",
    "            $file.write_all(format_as_bytes!(\"{}{}{}\\n\", $lq, line, $rq))?;",
    "        }",
    "    }",
    "}",
    "",
    "use std::fs::File;",
    "use std::io::prelude::*;",
    "use std::process::Command;",
    "",
    "fn write_source_file(source_name: &str, i: i32) -> std::io::Result<()> {",
    "    let mut file = File::create(source_name)?;",
    "    let quoted_src_iter = SRC.iter().map(|s| s.escape_debug().to_string());",
    "    let mut raw_src_iter = SRC.iter().map(|s| String::from(*s));",
    "    file.write_all(format_as_bytes!(\"static I: i32 = {};\\n\", i))?;",
    "    file.write_all(format_as_bytes!(\"{}\\n\", raw_src_iter.next().unwrap()))?;",
    "    print_iterator!(file, quoted_src_iter, \"    \\\"\", \"\\\",\");",
    "    print_iterator!(file, raw_src_iter, \"\", \"\");",
    "    Ok(())",
    "}",
    "",
    "fn not_a_main() -> std::io::Result<()> {",
    "    let current_file = file!();",
    "    let mut i = I;",
    "    if current_file != \"Sully.rs\" {",
    "        i -= 1;",
    "    }",
    "    if i < 0 {",
    "        return Ok(())",
    "    }",
    "    let source_name = format!(\"Sully_{}.rs\", i);",
    "    let exec_name = format!(\"./Sully_{}\", i);",
    "    write_source_file(&source_name, i)?;",
    "    Command::new(\"rustc\").arg(&source_name).status()?;",
    "    Command::new(&exec_name).status()?;",
    "    Ok(())",
    "}",
    "",
    "start_program!();",
];

macro_rules! start_program {
    () => {
        fn main() -> std::io::Result<()> { not_a_main()?; Ok(()) }
    }
}

macro_rules! format_as_bytes {
    ($fmt:literal, $($all_exprs:expr),*) => {
        format!($fmt, $($all_exprs),*).as_bytes()
    }
}

macro_rules! print_iterator {
    ($file:ident, $str_iter:ident, $lq:expr, $rq:expr) => {
        for line in $str_iter {
            $file.write_all(format_as_bytes!("{}{}{}\n", $lq, line, $rq))?;
        }
    }
}

use std::fs::File;
use std::io::prelude::*;
use std::process::Command;

fn write_source_file(source_name: &str, i: i32) -> std::io::Result<()> {
    let mut file = File::create(source_name)?;
    let quoted_src_iter = SRC.iter().map(|s| s.escape_debug().to_string());
    let mut raw_src_iter = SRC.iter().map(|s| String::from(*s));
    file.write_all(format_as_bytes!("static I: i32 = {};\n", i))?;
    file.write_all(format_as_bytes!("{}\n", raw_src_iter.next().unwrap()))?;
    print_iterator!(file, quoted_src_iter, "    \"", "\",");
    print_iterator!(file, raw_src_iter, "", "");
    Ok(())
}

fn not_a_main() -> std::io::Result<()> {
    let current_file = file!();
    let mut i = I;
    if current_file != "Sully.rs" {
        i -= 1;
    }
    if i < 0 {
        return Ok(())
    }
    let source_name = format!("Sully_{}.rs", i);
    let exec_name = format!("./Sully_{}", i);
    write_source_file(&source_name, i)?;
    Command::new("rustc").arg(&source_name).status()?;
    if i != 0 {
        Command::new(&exec_name).status()?;
    }
    Ok(())
}

start_program!();
