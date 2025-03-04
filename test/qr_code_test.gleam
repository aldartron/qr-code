import gleeunit
import gleeunit/should
import qr_code

pub fn main() {
  gleeunit.main()
}

pub fn get_encoding_mode_test() {
  qr_code.get_encoding_mode("123") |> should.equal(<<0b0001:1>>)
  qr_code.get_encoding_mode("alpha123") |> should.equal(<<0b0010:1>>)
  qr_code.get_encoding_mode("http://latin1.test") |> should.equal(<<0b0100:1>>)
  qr_code.get_encoding_mode("Ё") |> should.equal(<<0b0111:1>>)
  qr_code.get_encoding_mode("") |> should.equal(<<0b0111:1>>)
  qr_code.get_encoding_mode("\n") |> should.equal(<<0b0111:1>>)
}
