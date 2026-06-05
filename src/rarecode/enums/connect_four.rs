const ROWS: usize = 6;
const COLS: usize = 7;

pub type Board = [[Square; COLS]; ROWS];

#[derive(Debug, Copy, Clone, PartialEq)]
pub enum Color {
    Yellow,
    Red,
}
#[derive(Debug, Copy, Clone, PartialEq)]
pub enum Square {
    Occupied(Color),
    Unused,
}

pub fn main() {
    let mut board = create_board();

    // Test placing a few pieces
    place_piece(&mut board, 3, Color::Yellow);
    place_piece(&mut board, 3, Color::Red);
    place_piece(&mut board, 0, Color::Yellow);

    println!("{}", printable_board(&board));

    /* expected:
    | | | | | | | |
    | | | | | | | |
    | | | | | | | |
    | | | | | | | |
    | | | |R| | | |
    | | | |Y| | | |
    */
}

pub fn create_board() -> Board {
    [[Square::Unused; COLS]; ROWS]
}

pub fn printable_board(board: &Board) -> String {
    let mut repr = String::from("");

    /*
    | | | | | | | |
    | | | | | | | |
    | | | | | | | |
    | | | | | | | |
    | | | | | | | |
    | | | | | | | |
    */

    // your code here
    for row in board.iter().rev() {
        repr.push_str(&print_row(row));
    }

    repr
}

fn print_row(row: &[Square; COLS]) -> String {
    let mut result: String = "|".into();

    for value in row.iter() {
        result.push_str(match *value {
            Square::Occupied(Color::Yellow) => "Y|",
            Square::Occupied(Color::Red) => "R|",
            Square::Unused => " |",
        });
    }
    result.push_str("\n");

    result
}

pub fn place_piece(board: &mut Board, col: usize, color: Color) {
    let warning = "Column is full";

    if col >=COLS {
        panic!("{}", warning);
    }

    for row in board.iter_mut() {
        if let Square::Unused = row[col] {
            row[col] = Square::Occupied(color);
            return;
        }
    }

    panic!("{}", warning);
}
