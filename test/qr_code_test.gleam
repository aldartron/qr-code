import gleeunit
import gleeunit/should
import qr_code

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
