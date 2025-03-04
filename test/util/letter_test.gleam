import gleeunit/should
import util/letter

pub fn is_latin_test() {
  letter.is_latin("http://test.test?a=123&b=abc")
  |> should.equal(True)

  letter.is_latin("ё")
  |> should.equal(False)

}
