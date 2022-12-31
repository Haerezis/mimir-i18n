import TranslationValue from "@/types/Project/TranslationValue"

export default interface Translation {
  id?: number;
  project_id: number;
  key: string;
  previous_key?: string;
  values: { [key: string]: TranslationValue; };

  flagged_for_removal: boolean;
}
