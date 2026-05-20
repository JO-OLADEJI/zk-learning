use std::collections::HashSet;

fn main() {
    println!("hello world!");

    let order: u32 = 11;
    // bn_128 curve: y2 = x3 + 3
    // (x, y) -> (4, 10)
    //
    //    y
    //
    // 10 |             ●
    //  9 |    ●
    //  8 |                         ●
    //  7 |                      ●
    //  6 | ●
    //  5 | ●
    //  4 |                      ●
    //  3 |                         ●
    //  2 |    ●
    //  1 |             ●
    //  0 |       ●
    //    +-----------------------------------  x
    //      0  1  2  3  4  5  6  7  8  9 10

    for x in 0..order {
        let y = compute_root((x.pow(3) + 3) % order, order);

        if !y.is_empty() {
            for root in y.into_iter() {
                println!("({x}, {root})")
            }
            // println!("");
        }
    }
}

pub fn compute_root(d: u32, field_order: u32) -> HashSet<u32> {
    let mut result: HashSet<u32> = HashSet::new();

    for i in 0..field_order {
        let square = i.pow(2);

        if square % field_order == d {
            result.insert(i);
        }
    }

    result
}
