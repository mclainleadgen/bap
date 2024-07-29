import { sum } from './sum';

test('5 + 2 = 7', () => {
  const a: string = '5';
  expect(a).toBe('5');
  expect(sum(5, 2)).toBe(7);
});
