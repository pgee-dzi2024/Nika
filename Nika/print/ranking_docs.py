from docxtpl import DocxTemplate
from datetime import datetime
from typing import List, Dict, Any, Optional
import os

BASE_DIR = os.path.dirname(os.path.abspath(__file__))


class RankingDocBuilder:
    def __init__(self):
        templates_dir = os.path.join(BASE_DIR, 'templates')
        self.template_path_ = os.path.join(templates_dir, 'ranking_.docx')
        self.template_path_g = os.path.join(templates_dir, 'ranking_g.docx')
        self.template_path_s = os.path.join(templates_dir, 'ranking_s.docx')
        self.template_path_gs = os.path.join(templates_dir, 'ranking_gs.docx')

        print("BASE_DIR =", BASE_DIR)
        print("Expecting templates in:", os.path.join(BASE_DIR, 'templates'))
        print("Template paths:")
        print(" _ :", self.template_path_)
        print(" g :", self.template_path_g)
        print(" s :", self.template_path_s)
        print(" gs :", self.template_path_gs)
        print("Exists _ :", os.path.exists(self.template_path_))

        for p in (self.template_path_, self.template_path_g, self.template_path_s, self.template_path_gs):
            if not os.path.exists(p):
                raise FileNotFoundError(f"Template not found: {p}")

    def _normalize_athlete(self, athlete: Dict[str, Any]) -> Dict[str, Any]:
        return {
            'num': athlete.get('num'),
            'bib': athlete.get('bib_number'),
            'name': athlete.get('name'),
            'time': athlete.get('result_time'),
            'gender_text': 'мъже' if athlete.get('gender') else 'жени' if athlete.get('gender') is not None else '',
            'group_id': athlete['group'].get('id'),
            'group_name': athlete['group'].get('name'),
            'group_comment': athlete['group'].get('comment'),
            'status': athlete.get('status'),
        }

    def render_list_(self, ranking_list, group_list, filename, mode, count):
        if mode == ' ':
            tpl = DocxTemplate(self.template_path_)
        elif mode =='g':
            tpl = DocxTemplate(self.template_path_g)
        elif mode =='s':
            tpl = DocxTemplate(self.template_path_s)
        else:
            tpl = DocxTemplate(self.template_path_gs)
        rows = [self._normalize_athlete(a) for a in ranking_list]
        groups = group_list
        context = {
            'count': count,
            'groups': groups,
            'athletes': rows,
        }
        tpl.render(context)

        out_dir = os.path.join(os.getcwd(), "rankings")
        os.makedirs(out_dir, exist_ok=True)
        output_path = os.path.join(out_dir, filename)
        tpl.save(output_path)
        return output_path

