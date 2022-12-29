export interface ProjectNew {
  name: string;
  locales: string[];
}

export default interface Project {
  id: number;
  owner_id: number;
  owner_fullname: string;
  name: string;
  locales: string[];
}
