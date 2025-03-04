import gleam/regexp

const lating_regex = "^[\\x00-\\xff]*$"

pub fn is_latin(input: String) -> Bool {
    let assert Ok(re) = regexp.from_string(lating_regex)
    regexp.check(re, input)
}
