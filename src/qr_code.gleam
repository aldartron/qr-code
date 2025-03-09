import gleam/list
import gleam/regexp
import gleam/result
import gleam/string
import versions.{VersionSpec}

// const latin_mode = <<0b0100:1>>

pub type QrError {
  LengthTooBig(max: Int, was: Int)
  InputIsEmpty
}

pub fn is_latin(input: String) -> Bool {
  regexp.from_string("^[\\x00-\\xff]*$")
  |> result.map(fn(re) { regexp.check(re, input) })
  |> result.unwrap(False)
}

pub fn get_min_version(length: Int) -> Result(versions.VersionSpec, QrError) {
  versions.capacities
  |> list.find(fn(a) {
    let #(l, _, _) = a
    l >= length
  })
  |> result.map(fn(a) {
    let #(_, v, c) = a
    VersionSpec(version: v, correction: c)
  })
  |> result.replace_error(LengthTooBig(max: max_input_length, was: length))
}

const max_input_length = 500

pub fn check_length(input: String) -> Result(String, QrError) {
  case string.length(input) {
    0 -> Error(InputIsEmpty)
    i if i > max_input_length ->
      Error(LengthTooBig(max: max_input_length, was: i))
    _ -> Ok(input)
  }
}
