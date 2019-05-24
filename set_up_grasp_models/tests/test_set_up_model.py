import os
import unittest
from unittest.mock import patch
import pandas as pd

from set_up_grasp_models.set_up_models.set_up_model import set_up_model


class TestSetUpModel(unittest.TestCase):

    def setUp(self):
        self.test_folder = os.path.join('test_files', 'test_set_up_models', 'set_up_model')
        self.file_in_stoic = os.path.join(self.test_folder, 'model_with_PPP_plaintext.txt')

    def test_set_up_model_empty_base(self):

        true_res = pd.read_excel(os.path.join(self.test_folder, 'true_res_model_v1.xlsx'), sheet_name=None)

        general_file = os.path.join(self.test_folder, 'GRASP_general.xlsx')
        model_name = 'model_v1'
        file_out = os.path.join(self.test_folder, model_name + '.xlsx')

        set_up_model(model_name, self.file_in_stoic, general_file, file_out)
        res = pd.read_excel(os.path.join(self.test_folder, model_name + '.xlsx'), sheet_name=None)

        self.assertListEqual(list(true_res.keys()), list(res.keys()))
        for key in true_res:
            self.assertTrue(true_res[key].equals(res[key]))

    def test_set_up_model_empty_base_error(self):

        general_file = os.path.join(self.test_folder, 'GRASP_general_error.xlsx')
        model_name = 'model_v1'
        file_out = os.path.join(self.test_folder, 'putida_v1.xlsx')

        with self.assertRaises(KeyError) as context:
            set_up_model(model_name, self.file_in_stoic, general_file, file_out)
            self.assertTrue(
                f'The base excel file {general_file} must contain a sheet named \'general\'' in context.exception)

    def test_set_up_model_not_empty_base(self):

        true_res = pd.read_excel(os.path.join(self.test_folder, 'true_res_model_v2.xlsx'), sheet_name=None)

        general_file = os.path.join(self.test_folder, 'model_v1_manual2_EX.xlsx')
        model_name = 'model_v2'
        file_out = os.path.join(self.test_folder, model_name + '.xlsx')

        set_up_model(model_name, self.file_in_stoic, general_file, file_out)
        res = pd.read_excel(os.path.join(self.test_folder, model_name + '.xlsx'), sheet_name=None)

        self.assertListEqual(list(true_res.keys()), list(res.keys()))
        for key in true_res:
            self.assertTrue(true_res[key].equals(res[key]))

    def test_set_up_model_not_empty_base_equilibrator(self):

        true_res = pd.read_excel(os.path.join(self.test_folder, 'true_res_model_v3.xlsx'), sheet_name=None)

        general_file = os.path.join(self.test_folder, 'model_v1_manual2_EX.xlsx')
        model_name = 'model_v3'
        file_out = os.path.join(self.test_folder, model_name + '.xlsx')
        with patch('builtins.input', side_effect=['']):
            set_up_model(model_name, self.file_in_stoic, general_file, file_out, use_equilibrator=True)
        res = pd.read_excel(os.path.join(self.test_folder, model_name + '.xlsx'), sheet_name=None)

        self.assertListEqual(list(true_res.keys()), list(res.keys()))
        for key in true_res:
            self.assertTrue(true_res[key].equals(res[key]))

    def test_set_up_model_not_empty_base_mets_file(self):

        true_res = pd.read_excel(os.path.join(self.test_folder, 'true_res_model_v4.xlsx'), sheet_name=None)

        general_file = os.path.join(self.test_folder, 'model_v1_manual2_EX.xlsx')
        file_in_mets_conc = os.path.join(self.test_folder, 'met_concs.xlsx')
        model_name = 'model_v4'
        file_out = os.path.join(self.test_folder, model_name + '.xlsx')

        with patch('builtins.input', side_effect=['']):
            set_up_model(model_name, self.file_in_stoic, general_file, file_out,
                         file_in_mets_conc=file_in_mets_conc)

        res = pd.read_excel(os.path.join(self.test_folder, model_name + '.xlsx'), sheet_name=None)

        self.assertListEqual(list(true_res.keys()), list(res.keys()))

        for key in true_res:
            self.assertTrue(true_res[key].equals(res[key]))