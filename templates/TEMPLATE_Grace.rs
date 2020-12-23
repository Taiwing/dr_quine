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

/* Hey! Loook at me, I am a comment! */
macro_rules! print_iterator {
    ($file:ident, $str_iter:ident, $lq:expr, $rq:expr) => {
        for line in $str_iter {
            $file.write_all(format_as_bytes!("{}{}{}\n", $lq, line, $rq))?;
        }
    }
}

use std::fs::File;
use std::io::prelude::*;

fn not_a_main() -> std::io::Result<()> {
    let mut file = File::create("Grace_kid.rs")?;
    let quoted_src_iter = SRC.iter().map(|s| s.escape_debug().to_string());
    let mut raw_src_iter = SRC.iter().map(|s| String::from(*s));
    file.write_all(format_as_bytes!("{}\n", raw_src_iter.next().unwrap()))?;
    print_iterator!(file, quoted_src_iter, "    \"", "\",");
    print_iterator!(file, raw_src_iter, "", "");
    Ok(())
}

start_program!();
