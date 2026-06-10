pub fn main() {
    let mut a = vec![1, 2, 3, 4];
    sum_of_prev_plus_curr(&mut a);
    println!("{:?}", a); // [1, 3, 7, 15]
}

pub fn sum_of_prev_plus_curr(sl: &mut [i32]) {
    let mut sum = 0;

    for (_, e) in sl.iter_mut().enumerate() {
        *e += sum;
        sum += *e;
    }
}
