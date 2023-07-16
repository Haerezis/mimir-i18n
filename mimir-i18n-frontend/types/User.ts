import Picture from '@/types/Picture'

export default interface User {
  id: number;
  firstname: string;
  lastname: string;
  email: string;
  picture: Picture;
}
