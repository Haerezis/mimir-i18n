import ProjectTranslationValue from "@/types/Project/ProjectTranslationValue"

export default interface ProjectTranslationKey {
  id?: number;
  project_id: number;
  key: string;
  previous_key?: string;
  values: { [key: string]: ProjectTranslationValue; };

  flagged_for_removal: boolean;
}
