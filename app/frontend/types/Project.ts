export interface ProjectNew {
  name: string;
  locales: string[];
}

export interface ProjectOwner {
  id: number;
  fullname: string;
}

export default interface Project {
  id: number;
  owner: ProjectOwner;
  name: string;
  locales: string[];
}
