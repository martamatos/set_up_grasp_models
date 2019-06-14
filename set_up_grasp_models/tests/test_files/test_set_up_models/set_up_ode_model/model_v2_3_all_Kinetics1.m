function [f,grad] = model_v2_3_all_Kinetics1(x,model,fixedExch,Sred,kinInactRxns,subunits,flag)
% Pre-allocation of memory
h = 1e-8;
% Defining metabolite and enzyme species
if flag==1
x = x(:);
v = zeros(49,84);
E = zeros(49,84);
x = [x,x(:,ones(1,83)) + diag(h*1i*ones(83,1))];
else
v = zeros(49,size(x,2));
E = zeros(49,size(x,2));
end
% Defining metabolite and enzyme species
m_m_glc__D_p = x(1,:);
m_m_atp_c = x(2,:);
m_m_glc__D_c = x(3,:);
m_m_adp_c = x(4,:);
m_m_g6p_c = x(5,:);
m_m_glcn_p = x(6,:);
m_m_glcn_c = x(7,:);
m_m_6pgc_c = x(8,:);
m_m_2dhglcn_p = x(9,:);
m_m_2dhglcn_c = x(10,:);
m_m_6p2dhglcn_c = x(11,:);
m_m_nadh_c = x(12,:);
m_m_nad_c = x(13,:);
m_m_nadph_c = x(14,:);
m_m_nadp_c = x(15,:);
m_m_6pgl_c = x(16,:);
m_m_ru5p__D_c = x(17,:);
m_m_r5p_c = x(18,:);
m_m_xu5p__D_c = x(19,:);
m_m_g3p_c = x(20,:);
m_m_s7p_c = x(21,:);
m_m_e4p_c = x(22,:);
m_m_f6p_c = x(23,:);
m_m_2ddg6p_c = x(24,:);
m_m_pyr_c = x(25,:);
m_m_fdp_c = x(26,:);
m_m_dhap_c = x(27,:);
m_m_13dpg_c = x(28,:);
m_m_3pg_c = x(29,:);
m_m_2pg_c = x(30,:);
m_m_pep_c = x(31,:);
m_m_h2o2_c = x(32,:);
m_m_gthrd_c = x(33,:);
m_m_gthox_c = x(34,:);
E(1,:) = x(35,:);
E(2,:) = x(36,:);
E(3,:) = x(37,:);
E(4,:) = x(38,:);
E(5,:) = x(39,:);
E(6,:) = x(40,:);
E(7,:) = x(41,:);
E(8,:) = x(42,:);
E(9,:) = x(43,:);
E(10,:) = x(44,:);
E(11,:) = x(45,:);
E(12,:) = x(46,:);
E(13,:) = x(47,:);
E(14,:) = x(48,:);
E(15,:) = x(49,:);
E(16,:) = x(50,:);
E(17,:) = x(51,:);
E(18,:) = x(52,:);
E(19,:) = x(53,:);
E(20,:) = x(54,:);
E(21,:) = x(55,:);
E(22,:) = x(56,:);
E(23,:) = x(57,:);
E(24,:) = x(58,:);
E(25,:) = x(59,:);
E(26,:) = x(60,:);
E(27,:) = x(61,:);
E(28,:) = x(62,:);
E(29,:) = x(63,:);
E(30,:) = x(64,:);
E(31,:) = x(65,:);
E(32,:) = x(66,:);
E(33,:) = x(67,:);
E(34,:) = x(68,:);
E(35,:) = x(69,:);
E(36,:) = x(70,:);
E(37,:) = x(71,:);
E(38,:) = x(72,:);
E(39,:) = x(73,:);
E(40,:) = x(74,:);
E(41,:) = x(75,:);
E(42,:) = x(76,:);
E(43,:) = x(77,:);
E(44,:) = x(78,:);
E(45,:) = x(79,:);
E(46,:) = x(80,:);
E(47,:) = x(81,:);
E(48,:) = x(82,:);
E(49,:) = x(83,:);
% Reaction rates
v(1,:) = r_R_GLCabcpp1([m_m_glc__D_p;m_m_atp_c;m_m_adp_c;ones(1,size(x,2));m_m_glc__D_c],model.rxnParams(1).kineticParams);
v(2,:) = r_R_GLK1([ones(1,size(x,2));m_m_atp_c;m_m_adp_c;m_m_g6p_c],model.rxnParams(2).kineticParams);
v(3,:) = r_R_GLCNt2rpp1([m_m_glcn_p;m_m_glcn_c],model.rxnParams(3).kineticParams);
v(4,:) = r_R_GNK1([m_m_glcn_c;m_m_atp_c;m_m_adp_c;m_m_6pgc_c],[m_m_gthox_c],model.rxnParams(4).kineticParams,model.rxnParams(4).KnegEff,model.rxnParams(4).L,subunits(4));
v(5,:) = r_R_2DHGLCNkt_tpp1([m_m_2dhglcn_p;m_m_2dhglcn_c],model.rxnParams(5).kineticParams);
v(6,:) = r_R_2DHGLCK1([m_m_atp_c;m_m_2dhglcn_c;m_m_6p2dhglcn_c;m_m_adp_c],model.rxnParams(6).kineticParams);
v(7,:) = r_R_PGLCNDH_NAD1([m_m_nadh_c;m_m_6p2dhglcn_c;m_m_nadph_c;m_m_6p2dhglcn_c;m_m_nad_c;m_m_nadp_c;m_m_6pgc_c;m_m_6pgc_c],model.rxnParams(7).kineticParams);
v(8,:) = r_R_PGLCNDH_NADP1([m_m_nadh_c;m_m_6p2dhglcn_c;m_m_nadph_c;m_m_6p2dhglcn_c;m_m_nad_c;m_m_nadp_c;m_m_6pgc_c;m_m_6pgc_c],model.rxnParams(8).kineticParams);
v(9,:) = r_R_GLCDpp1([m_m_glc__D_p;ones(1,size(x,2));m_m_glcn_p;ones(1,size(x,2))],model.rxnParams(9).kineticParams);
v(10,:) = r_R_GAD2ktpp1([ones(1,size(x,2));m_m_glcn_p;m_m_2dhglcn_p;ones(1,size(x,2))],model.rxnParams(10).kineticParams);
v(11,:) = r_R_G6PDH21([m_m_nadp_c;m_m_g6p_c;m_m_6pgl_c;m_m_nadph_c],[m_m_nadph_c;m_m_nadh_c],model.rxnParams(11).kineticParams,model.rxnParams(11).KnegEff,model.rxnParams(11).L,subunits(11));
v(12,:) = r_R_G6PDH2_NAD1([m_m_nad_c;m_m_g6p_c;m_m_nadp_c;m_m_g6p_c;m_m_6pgl_c;m_m_6pgl_c;m_m_nadh_c;m_m_nadph_c],[m_m_nadph_c;m_m_nadh_c],model.rxnParams(12).kineticParams,model.rxnParams(12).KnegEff,model.rxnParams(12).L,subunits(12));
v(13,:) = r_R_G6PDH2_NADP1([m_m_nad_c;m_m_g6p_c;m_m_nadp_c;m_m_g6p_c;m_m_6pgl_c;m_m_6pgl_c;m_m_nadh_c;m_m_nadph_c],[m_m_nadph_c;m_m_nadh_c],model.rxnParams(13).kineticParams,model.rxnParams(13).KnegEff,model.rxnParams(13).L,subunits(13));
v(14,:) = r_R_PGL1([m_m_6pgl_c;m_m_6pgc_c],model.rxnParams(14).kineticParams);
v(15,:) = r_R_GND_NAD1([m_m_6pgc_c;m_m_nad_c;m_m_6pgc_c;m_m_nadp_c;m_m_nadh_c;m_m_nadph_c;m_m_ru5p__D_c;m_m_ru5p__D_c],[m_m_nadph_c],model.rxnParams(15).kineticParams,model.rxnParams(15).KnegEff,model.rxnParams(15).L,subunits(15));
v(16,:) = r_R_GND_NADP1([m_m_6pgc_c;m_m_nad_c;m_m_6pgc_c;m_m_nadp_c;m_m_nadh_c;m_m_nadph_c;m_m_ru5p__D_c;m_m_ru5p__D_c],[m_m_nadph_c],model.rxnParams(16).kineticParams,model.rxnParams(16).KnegEff,model.rxnParams(16).L,subunits(16));
v(17,:) = r_R_RPI1([m_m_ru5p__D_c;m_m_r5p_c],model.rxnParams(17).kineticParams);
v(18,:) = r_R_RPE1([m_m_ru5p__D_c;m_m_xu5p__D_c],model.rxnParams(18).kineticParams);
v(19,:) = r_R_TKT11([m_m_r5p_c;m_m_xu5p__D_c;m_m_g3p_c;m_m_s7p_c],model.rxnParams(19).kineticParams);
v(20,:) = r_R_TKT21([m_m_xu5p__D_c;m_m_e4p_c;m_m_g3p_c;m_m_f6p_c],model.rxnParams(20).kineticParams);
v(21,:) = r_R_TALA1([m_m_s7p_c;m_m_g3p_c;m_m_e4p_c;m_m_f6p_c],model.rxnParams(21).kineticParams);
v(22,:) = r_R_EDD1([m_m_6pgc_c;m_m_2ddg6p_c],[m_m_nadph_c],model.rxnParams(22).kineticParams,model.rxnParams(22).KposEff,model.rxnParams(22).L,subunits(22));
v(23,:) = r_R_EDA1([m_m_2ddg6p_c;m_m_g3p_c;m_m_pyr_c],model.rxnParams(23).kineticParams);
v(24,:) = r_R_PGI1([m_m_g6p_c;m_m_f6p_c],model.rxnParams(24).kineticParams);
v(25,:) = r_R_FBP1([m_m_fdp_c;m_m_f6p_c;ones(1,size(x,2))],model.rxnParams(25).kineticParams);
v(26,:) = r_R_FBA1([m_m_dhap_c;m_m_g3p_c;m_m_fdp_c],model.rxnParams(26).kineticParams);
v(27,:) = r_R_TPI1([m_m_g3p_c;m_m_dhap_c],model.rxnParams(27).kineticParams);
v(28,:) = r_R_GAPD1([m_m_nad_c;m_m_g3p_c;ones(1,size(x,2));m_m_13dpg_c;m_m_nadh_c],[m_m_h2o2_c],model.rxnParams(28).kineticParams,model.rxnParams(28).KnegEff,model.rxnParams(28).L,subunits(28));
v(29,:) = r_R_PGK1([m_m_adp_c;m_m_13dpg_c;m_m_3pg_c;m_m_atp_c],model.rxnParams(29).kineticParams);
v(30,:) = r_R_PGM1([m_m_3pg_c;m_m_2pg_c],model.rxnParams(30).kineticParams);
v(31,:) = r_R_ENO1([m_m_2pg_c;m_m_pep_c],model.rxnParams(31).kineticParams);
v(32,:) = r_R_PYK1([m_m_adp_c;m_m_pep_c;m_m_atp_c;m_m_pyr_c],[m_m_2ddg6p_c;m_m_r5p_c;m_m_f6p_c],model.rxnParams(32).kineticParams,model.rxnParams(32).KposEff,model.rxnParams(32).L,subunits(32));
v(33,:) = r_R_GTHPi1([m_m_h2o2_c;m_m_gthrd_c;m_m_gthox_c;],model.rxnParams(33).kineticParams);
v(34,:) = r_R_GTHOr1([m_m_nadph_c;m_m_gthox_c;m_m_nadp_c;m_m_gthrd_c],model.rxnParams(34).kineticParams);
v(35,:) = r_R_AXPr1(m_m_atp_c,m_m_adp_c,model.rxnParams(35).kineticParams);
v(36,:) = r_R_NADHr1(m_m_nadh_c,m_m_nad_c,model.rxnParams(36).kineticParams);
v(37,:) = r_R_NADPHr1(m_m_nadph_c,m_m_nadp_c,model.rxnParams(37).kineticParams);
v(38,:) = r_R_EX_pyr1(m_m_pyr_c,ones(1,size(x,2)),model.rxnParams(38).kineticParams);
v(39,:) = r_R_EX_pep1(m_m_pep_c,ones(1,size(x,2)),model.rxnParams(39).kineticParams);
v(40,:) = r_R_EX_h2o21(ones(1,size(x,2)),m_m_h2o2_c,model.rxnParams(40).kineticParams);
v(41,:) = r_R_EX_g6p1(m_m_g6p_c,ones(1,size(x,2)),model.rxnParams(41).kineticParams);
v(42,:) = r_R_EX_6pgc1(ones(1,size(x,2)),m_m_6pgc_c,model.rxnParams(42).kineticParams);
v(43,:) = r_R_EX_r5p1(m_m_r5p_c,ones(1,size(x,2)),model.rxnParams(43).kineticParams);
v(44,:) = r_R_EX_xu5p__D1(ones(1,size(x,2)),m_m_xu5p__D_c,model.rxnParams(44).kineticParams);
v(45,:) = r_R_EX_g3p1(m_m_g3p_c,ones(1,size(x,2)),model.rxnParams(45).kineticParams);
v(46,:) = r_R_EX_e4p1(m_m_e4p_c,ones(1,size(x,2)),model.rxnParams(46).kineticParams);
v(47,:) = r_R_EX_f6p1(m_m_f6p_c,ones(1,size(x,2)),model.rxnParams(47).kineticParams);
v(48,:) = r_R_EX_3pg1(m_m_3pg_c,ones(1,size(x,2)),model.rxnParams(48).kineticParams);
v(49,:) = r_R_GLCtex1(ones(1,size(x,2)),m_m_glc__D_p,model.rxnParams(49).kineticParams);
if flag==1
% Final rates
y = sum((Sred*(E.*v)).^2);
f = real(y(1));
if (nargout>1) % gradient is required
grad = imag(y(2:end))/h;
end
else
f = E.*v;
grad = [];
end