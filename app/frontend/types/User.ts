import Picture from '@/types/Picture.ts'

export default interface User {
  id: number;
  firstname: string;
  lastname: string;
  email: string;
  picture: Picture;
}
