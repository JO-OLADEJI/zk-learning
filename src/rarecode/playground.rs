fn main() {
    let sl = "hello";
    let num = 56;
    let a = [1, 2, 3];

    let result_1 = make_string(sl);
    let result_2 = upcast(num);
    let result_3 = make_vector(&a);

    println!("{:?} {:?} {:?}", result_1, result_2, result_3);
}

pub fn make_string(sl: &str) -> String {
    String::from(sl)
}

pub fn upcast(x: i16) -> i32 {
    i32::from(x)
}

pub fn make_vector(sl: &[i32]) -> Vec<i32> {
    Vec::from(sl)
}
