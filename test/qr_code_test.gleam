import gleam/int
import gleam/io
import gleam/list
import gleam/string
import gleeunit
import gleeunit/should
import qr_code
import versions.{VersionSpec}

pub fn main() {
  gleeunit.main()
}

pub fn is_latin_test() {
  qr_code.is_latin("123") |> should.equal(True)
  qr_code.is_latin("http://latin1.test") |> should.equal(True)
  qr_code.is_latin("Ё") |> should.equal(False)
  qr_code.is_latin("") |> should.equal(True)
  qr_code.is_latin("\n") |> should.equal(True)
}

pub fn check_length_test() {
  qr_code.check_length(string.repeat("a", 1))
  |> should.be_ok
  |> should.equal("a")

  qr_code.check_length(string.repeat("a", 123))
  |> should.be_ok

  qr_code.check_length(string.repeat("a", 500))
  |> should.be_ok

  qr_code.check_length("")
  |> should.be_error
  |> should.equal(qr_code.InputIsEmpty)

  qr_code.check_length(string.repeat("a", 501))
  |> should.be_error
  |> should.equal(qr_code.LengthTooBig(500, 501))
}

pub fn get_min_version_test() {
  qr_code.get_min_version(0)
  |> should.be_ok
  |> should.equal(VersionSpec(1, versions.H))

  qr_code.get_min_version(120)
  |> should.be_ok
  |> should.equal(VersionSpec(6, versions.L))

  qr_code.get_min_version(1171)
  |> should.be_ok
  |> should.equal(VersionSpec(24, versions.L))

  qr_code.get_min_version(100_000)
  |> should.be_error
  |> should.equal(qr_code.LengthTooBig(500, 100_000))
}
