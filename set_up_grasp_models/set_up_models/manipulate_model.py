import numpy as np
import pandas as pd


def reorder_reactions(data_dict: dict, rxn_list: list, file_out: str):
    """
    Given a dictionary representing a GRASP input excel and a list of reactions it reorders the reaction in
    all excel sheets that and writes the new reordered sheets to file_out

    Args:
        data_dict: dictionary representing GRASP input excel file.
        rxn_list: list with the new reaction order.
        file_out: path to excel input file to be outputed.

    Returns:
        None
    """

    sheets_to_reorder = ['stoic', 'rxns', 'splitRatios', 'thermoRxns', 'measRates', 'protData', 'kinetics1']
    writer = pd.ExcelWriter(file_out, engine='xlsxwriter')

    for sheet in data_dict.keys():

        if sheet in sheets_to_reorder:
            if sheet == 'measRates' and len(data_dict[sheet].index) != len(data_dict['stoic'].index):
                meas_rates_rxns = [rxn for rxn in rxn_list if rxn in data_dict[sheet].index]
                ordered_sheet = data_dict[sheet].reindex(meas_rates_rxns)
            else:
                ordered_sheet = data_dict[sheet].reindex(rxn_list)

            ordered_sheet.to_excel(writer, sheet_name=sheet)

        else:
            data_dict[sheet].to_excel(writer, sheet_name=sheet)

    writer.save()


def remove_spaces(data_dict: dict, file_out: str):
    """
    Given a GRASP input model file removes trailing and leading spaces from all cells that contain strings.

    Args:
        data_dict: dictionary representing GRASP input excel file.
        file_out: path to excel input file to be outputed.

    Returns:
        None
    """

    writer = pd.ExcelWriter(file_out, engine='xlsxwriter')

    for sheet in data_dict.keys():
        data_dict[sheet] = data_dict[sheet].apply(lambda x: x.str.strip() if type(x) == str else x)
        data_dict[sheet].to_excel(writer, sheet_name=sheet)

    writer.save()


def rename_columns(data_dict: dict, file_out: str):
    """
    Given a GRASP input excel file, renames the columns and index names, so that these are standardize and don't cause
    problems with functions in this package.

    If the number of columns in the given excel file sheet is less than it should be, it adds columns filled with 0s.

    Args:
        data_dict: dictionary representing GRASP input excel file.
        file_out: path to excel input file to be outputed.

    Returns:
        None
    """

    sheet_column_names = {'mets': ['Metabolite name', 'balanced?', 'active?', 'fixed?'],
                          'rxns': ['reaction name', 'transportRxn?', 'modelled?', 'isoenzymes'],
                          'thermoRxns': ['∆Gr\'_min (kJ/mol)', '∆Gr\'_max (kJ/mol)'],
                          'thermoMets': ['min (M)', 'max (M)'],
                          'measRates': ['MBo10_mean', 'MBo10_std', 'MBo10_mean2', 'MBo10_std2'],
                          'protData': ['MBo10_LB2', 'MBo10_meas2', 'MBo10_UB2'],
                          'metsData': ['MBo10_LB2', 'MBo10_meas2', 'MBo10_UB2'],
                          'kinetics1': ['kinetic mechanism', 'substrate order', 'product order', 'promiscuous',
                                        'inhibitors', 'activators', 'negative effector', 'positive effector',
                                        'allosteric', 'subunits', 'mechanism_ref_type', 'mechanism_ref',
                                        'inhibitors_ref_type', 'inhibitors_ref', 'activators_ref_type',
                                        'activators_ref', 'negative_effectors_ref_type', 'negative_effectors_ref',
                                        'positive_effectors_ref_type', 'positive_effectors_ref', 'subunits_ref_type',
                                        'subunits_ref', 'comments']}

    sheet_index_name = {'stoic': 'rxn ID',
                        'mets': 'ID',
                        'rxns': 'ID',
                        'splitRatios': 'ID',
                        'poolConst': 'met',
                        'thermo_ineq_constraints': 'met',
                        'thermoRxns': 'rxn',
                        'thermoMets': 'met',
                        'measRates': 'Fluxes (umol/gCDW/h)',
                        'protData': 'enzyme/rxn',
                        'metsData': 'met',
                        'kinetics1': 'reaction ID'}

    writer = pd.ExcelWriter(file_out, engine='xlsxwriter')

    for sheet in data_dict.keys():

        if sheet in sheet_column_names:

            if len(data_dict[sheet].columns) != len(sheet_column_names[sheet]):
                for col_i in range(len(data_dict[sheet].columns), len(sheet_column_names[sheet])):
                    data_dict[sheet][col_i] = np.zeros([len(data_dict[sheet].index), 1])

            data_dict[sheet].columns = sheet_column_names[sheet]

        if sheet in sheet_index_name:
            data_dict[sheet].index.name = sheet_index_name[sheet]

        data_dict[sheet].to_excel(writer, sheet_name=sheet)

    writer.save()
