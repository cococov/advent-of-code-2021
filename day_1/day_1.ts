const input: number[] = Deno.readTextFileSync('./input_1').split('\n').map(n => parseInt(n));

const result1: number = input.reduce((acc, curr, index, arr) => (index !== 0 && arr[index - 1] < curr) ? ++acc : acc, 0);

console.log(`Answer 1: ${result1}`);

const sum = (a: number, b: number) => a + b;

const result2: number = input.reduce((acc, _curr, index, arr) => {
  return (index < 3)
    ? acc
    : arr.slice(index - 3, index).reduce(sum) < arr.slice(index - 2, index + 1).reduce(sum)
      ? ++acc
      : acc;
}, 0);

console.log(`Answer 2: ${result2}`);