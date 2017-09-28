extern crate json_typegen_shared;

use std::os::raw::c_char;
use std::ffi::CStr;
use std::ffi::CString;

fn my_string_safe(i: *mut c_char) -> String {
    unsafe {
      CStr::from_ptr(i).to_string_lossy().into_owned()
    }
}

#[no_mangle]
pub fn uppercase(i: *mut c_char) -> *mut c_char {
    let input = my_string_safe(i);

    let output = input.to_uppercase();

    CString::new(output.as_str()).unwrap().into_raw()
}

#[no_mangle]
pub fn codegen(i: *mut c_char) -> *mut c_char {
    let input = my_string_safe(i);

    let output = json_typegen_shared::codegen_from_macro(&input);

    match output {
        Ok(code) => CString::new(code.as_str()).unwrap().into_raw(),
        Err(err) => {
            let err_as_string: String = format!("{}", err);
            CString::new(err_as_string).unwrap().into_raw()
        }
    }
}

fn main() {}
