/*
 * You are given a slice, a usize k and a target i32.
 * Find a contiguous subslice of size k in the slice such that the elements add up to target.
 * If none exists or if k is larger than the length of the slice, return None. If you find the slice, return the starting index as Some(index).
 * If there are multiple candidate sub slices, return the first one. If k = 0, return None.
 * Examples:
 * [1,2,3,4], k = 2, target = 5 -> Some(1)
 * [], k = 1, -> None
 * [], k = 0, -> None
 * [1,2,3], k = 1, target = 3 -> Some(2)
 * [1,2,3], k = 1, target = 4 -> None
 */

pub fn main() {
    let a = [1, 2, 3, 4, 1, 2];
    let k = 3;
    let target = 8;

    let result = find_region(&a, k, target);
    println!("{:?}", result);
}

pub fn find_region(sl: &[i32], k: usize, target: i32) -> Option<usize> {
    if k == 0 || k > sl.len() {
        return None;
    }

    for i in 0..=(sl.len() - k) {
        let sum: i32 = sl[i..i + k].iter().copied().sum();

        if sum == target {
            return Some(i);
        }
    }

    None
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_find_region_some() {
        let specimen: ([i32; 4], usize, i32) = ([1, 2, 3, 4], 2, 5);
        let specimen2: ([i32; 3], usize, i32) = ([1, 2, 3], 1, 3);

        assert_eq!(find_region(&specimen.0, specimen.1, specimen.2), Some(1));
        assert_eq!(find_region(&specimen2.0, specimen2.1, specimen2.2), Some(2));
    }

    #[test]
    fn test_find_region_none() {
        let specimen: ([i32; 0], usize, i32) = ([], 1, 1);
        let specimen2: ([i32; 0], usize, i32) = ([], 0, 1);
        let specimen3: ([i32; 3], usize, i32) = ([1, 2, 3], 1, 4);

        assert_eq!(find_region(&specimen.0, specimen.1, specimen.2), None);
        assert_eq!(find_region(&specimen2.0, specimen2.1, specimen2.2), None);
        assert_eq!(find_region(&specimen3.0, specimen3.1, specimen3.2), None);
    }
}
