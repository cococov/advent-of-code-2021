const input: number[] = Deno.readTextFileSync('./input_1').split('\n').map(n => parseInt(n));

const result1: number = input.reduce((acc, curr, index, arr) => (index !== 0 && arr[index - 1] < curr) ? ++acc : acc, 0);

console.log(`Answer 1: ${result1}`);

const result2: number = input.reduce((acc, curr, index, arr) => {
  return (index < 3)
    ? acc
    : arr[index - 3] < curr
      ? ++acc
      : acc;
}, 0);

console.log(`Answer 2: ${result2}`);