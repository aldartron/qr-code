import gleam/list
import gleam/regexp
import gleam/result

const fallback_mode = Mode("ECI", "^.+$", <<0b0111:1>>)

const modes = [
  Mode("Numeric", "^\\d*$", <<0b0001:1>>),
  Mode("Alphanumeric", "^[\\dA-Z $%*+\\-./:]*$/", <<0b0010:1>>),
  Mode("Byte", "^[\\x00-\\xff]*$", <<0b0100:1>>),
  fallback_mode,
]

type Mode {
  Mode(name: String, regexp: String, value: BitArray)
}

pub fn get_encoding_mode(input: String) -> BitArray {
  list.find(modes, fn(m) { check_mode(input, m) })
  |> result.map(fn(m) { m.value })
  |> result.unwrap(fallback_mode.value)
}

fn check_mode(input: String, mode: Mode) {
  let assert Ok(check) =
    regexp.from_string(mode.regexp)
    |> result.map(regexp.check(_, input))
  check
}
