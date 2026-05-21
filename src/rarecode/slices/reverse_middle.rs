/*
 * Exercise: Reverse the middle
 * You are given a mutable reference to a vector. Reverse the middle elements but leave the outer ones unchanged.
 * Example: [1,2,3,4] -> [1,3,2,4] [1,2,3] -> [1,2,3] [1,2,3,4,5] -> [1,4,3,2,5] [1,2,3,4,5,6] -> [1,5,4,3,2,6]
 * If the length of the vector is 3 or less, don't do anything.
 * Hint: reverse the middle portion in place by taking a mutable slice of that region and reverse by swapping with i with slice.len() - i - 1.
 * You can take a mutable slice of a mutable reference to a vector.
 * There is no need to clone anything or create an iterator.
 */

pub fn main() {
    let mut v = vec![1, 2, 3, 4, 5, 6];
    reverse_the_middle(&mut v);
    println!("{:?}", v);
}

pub fn reverse_the_middle(v: &mut Vec<i32>) {
    let v_len: usize = v.len();

    if v_len <= 3 {
        return;
    }

    let middle_elements = v[1..(v.len() - 1)].iter().copied().rev().collect::<Vec<i32>>();

    for (idx, value) in v[1..v_len - 1].iter_mut().enumerate() {
        *value = middle_elements[idx];
    }
}
