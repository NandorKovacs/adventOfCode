use std::{fs::File, io::Read, iter::zip};

const FILE: &str = "input.txt";

fn easy(mut l1: Vec<u64>, mut l2: Vec<u64>) -> u64 {
    l1.sort();
    l2.sort();
    let z = zip(l1, l2);
    let mut res = 0;
    for (x, y) in z {
        res += x.abs_diff(y);
    }
    return res;
}

fn hard(mut l1: Vec<u64>, mut l2: Vec<u64>) -> u64 {
    l1.sort();
    l2.sort();

    let mut i = 0;
    let mut j = 0;
    let mut res = 0;

    let mut res_buf = 0;
    let mut prev = 0;

    while i < l1.len() {
        if prev != l1[i] || i == 0 {
            res_buf = 0;
            while j < l2.len() && l2[j] <= l1[i] {
                if l2[j] == l1[i] {
                    res_buf += l1[i];
                }
                j += 1;
            }
        }
        res += res_buf;
        prev = l1[i];
        i += 1;
    }
    return res;
}

fn main() -> Result<(), std::io::Error> {
    let mut l1 = Vec::<u64>::new();
    let mut l2 = Vec::<u64>::new();

    let mut file = File::open(FILE).expect(&format!("failed to open {}", FILE));
    let mut fbuf = String::new();

    file.read_to_string(&mut fbuf).expect("couldnt read file");
    for line in fbuf.lines() {
        let buf: Vec<&str> = line.split_whitespace().collect();
        let x = buf[0].parse::<u64>().unwrap();
        let y = buf[1].parse::<u64>().unwrap();
        l1.push(x);
        l2.push(y);
    }

    println!("{}", easy(l1.clone(), l2.clone()));
    println!("{}", hard(l1.clone(), l2.clone()));
    return Result::Ok(());
}
