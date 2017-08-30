within ThreePhase.MonoTri_Branches;
model Line_MT "Transmission Line modeled as a PI element with a hybrid interface Single Phase x Three Phase"

  import ThreePhase.MonoTri_Branches.LineFcn.MT_InfiniteImpedances;
  import ThreePhase.MonoTri_Branches.LineFcn.MT_FiniteImpedance;
  
  outer OpenIPSL.Electrical.SystemBase SysData;
  OpenIPSL.Interfaces.PwPin p annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  OpenIPSL.Interfaces.PwPin A annotation (Placement(transformation(extent={{100,80},{120,100}})));
  OpenIPSL.Interfaces.PwPin B annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  OpenIPSL.Interfaces.PwPin C annotation (Placement(transformation(extent={{100,-100},{120,-80}})));
  
  
  parameter Real S = SysData.S_b "Nominal Power (MVA)" annotation (Dialog(group="Power flow data"));
  parameter Real f = SysData.fn "System Frequency" annotation (Dialog(group="Power flow data"));
  
  // Options for the type of model that the user wants to simulate
  parameter Integer ModelType = 0
  "0- Assuming that the negative and zero norton admittances are infinite (Aproximation), 1- Considering that the negative and zero norton admittances finite values;"
    annotation (Dialog(group="Selection of model"),choices(
      choice=0 "Norton admittances have infinite values",
      choice=1 "Norton admittances have finite values"));
          
  // Parameters for the abc model
  parameter Real Gseraa = 0 "in p.u." annotation (Dialog(group="Parameters for an 'abc'-Model"));
  parameter Real Bseraa = -10 "in p.u." annotation (Dialog(group="Parameters for an 'abc'-Model"));
  parameter Real Gserab = 0 "in p.u." annotation (Dialog(group="Parameters for an 'abc'-Model"));
  parameter Real Bserab = 0 "in p.u." annotation (Dialog(group="Parameters for an 'abc'-Model"));
  parameter Real Gserac = 0 "in p.u." annotation (Dialog(group="Parameters for an 'abc'-Model"));
  parameter Real Bserac = 0 "in p.u." annotation (Dialog(group="Parameters for an 'abc'-Model"));
  parameter Real Gserbb = 0 "in p.u." annotation (Dialog(group="Parameters for an 'abc'-Model"));
  parameter Real Bserbb = -10 "in p.u." annotation (Dialog(group="Parameters for an 'abc'-Model"));
  parameter Real Gserbc = 0 "in p.u." annotation (Dialog(group="Parameters for an 'abc'-Model"));
  parameter Real Bserbc = 0 "in p.u." annotation (Dialog(group="Parameters for an 'abc'-Model"));
  parameter Real Gsercc = 0 "in p.u." annotation (Dialog(group="Parameters for an 'abc'-Model"));
  parameter Real Bsercc = -10 "in p.u." annotation (Dialog(group="Parameters for an 'abc'-Model"));
  parameter Real Bshtaa = 0 "in p.u." annotation (Dialog(group="Parameters for an 'abc'-Model"));
  parameter Real Bshtab = 0 "in p.u." annotation (Dialog(group="Parameters for an 'abc'-Model"));
  parameter Real Bshtac = 0 "in p.u." annotation (Dialog(group="Parameters for an 'abc'-Model"));
  parameter Real Bshtbb = 0 "in p.u." annotation (Dialog(group="Parameters for an 'abc'-Model"));
  parameter Real Bshtbc = 0 "in p.u." annotation (Dialog(group="Parameters for an 'abc'-Model"));
  parameter Real Bshtcc = 0 "in p.u." annotation (Dialog(group="Parameters for an 'abc'-Model"));
  
  parameter Real G_0 = 0 "Zero sequence conductance in p.u." annotation (Dialog(group="Norton equivalent admittances in terminal K - Considering the negative and zero norton admittances have finite values"));                                   
  parameter Real B_0 = 0 "Zero sequence susceptance in p.u." annotation (Dialog(group="Norton equivalent admittances in terminal K - Considering the negative and zero norton admittances have finite values"));                                   
  parameter Real G_1 = 0 "Positive sequence conductance in p.u." annotation (Dialog(group="Norton equivalent admittances in terminal K - Considering the negative and zero norton admittances have finite values"));                                   
  parameter Real B_1 = 0 "Positive sequence susceptance in p.u." annotation (Dialog(group="Norton equivalent admittances in terminal K - Considering the negative and zero norton admittances have finite values"));                                   
  parameter Real G_2 = 0 "Negative sequence conductance in p.u." annotation (Dialog(group="Norton equivalent admittances in terminal K - Considering the negative and zero norton admittances have finite values"));                                   
  parameter Real B_2 = 0 "Negative sequence susceptance in p.u." annotation (Dialog(group="Norton equivalent admittances in terminal K - Considering the negative and zero norton admittances have finite values")); 
                                    
protected  
 //Writing the Y_ser matrix for the pi model
  parameter Real [1,18] Yser = [Gseraa, Bseraa, Gserab, Bserab, Gserac, Bserac, Gserab, Bserab, Gserbb, Bserbb, Gserbc, Bserbc, Gserac, Bserac, Gserbc, Bserbc, Gsercc, Bsercc];

  //Writing the Y_sht matrix for the pi model
  parameter Real [1,18] Ysht = [0, Bshtaa, 0, Bshtab, 0, Bshtac, 0, Bshtab, 0, Bshtbb, 0, Bshtbc, 0, Bshtac, 0, Bshtbc, 0, Bshtcc];

  //Writing the Y012 Norton matrix for the exact model
  parameter Real [1,18] Y012 = [G_0, B_0, 0, 0, 0, 0, 0, 0, G_1, B_1, 0, 0, 0, 0, 0, 0, G_2, B_2];
  
   function Model
    input Integer ModelType;
    input Real [1,18] Yser;
    input Real [1,18] Ysht;
    input Real [1,18] Y012;
    output Real[1,32] Y;
   algorithm
    if ModelType == 0 then
      Y := MT_InfiniteImpedances(
          Yser,
          Ysht);
    elseif ModelType == 1 then
      Y := MT_FiniteImpedance(
          Yser,
          Ysht,
          Y012);
    end if;
   end Model;
           
  //Calculating the parameters for the MonoxTri interface
  parameter Real[1,32] Aux = Model(ModelType, Yser, Ysht, Y012);
   parameter Real Ar = Aux[1,1];
   parameter Real Ai = Aux[1,2];
   parameter Real MB1r = Aux[1,3];
   parameter Real MB1i = Aux[1,4];
   parameter Real MB2r = Aux[1,5];
   parameter Real MB2i = Aux[1,6];
   parameter Real MB3r = Aux[1,7];
   parameter Real MB3i = Aux[1,8];
   parameter Real C1r = Aux[1,9];
   parameter Real C1i = Aux[1,10];
   parameter Real C2r = Aux[1,11];
   parameter Real C2i = Aux[1,12];
   parameter Real C3r = Aux[1,13];
   parameter Real C3i = Aux[1,14];
   parameter Real D11r = Aux[1,15];
   parameter Real D11i = Aux[1,16];
   parameter Real D12r = Aux[1,17];
   parameter Real D12i = Aux[1,18];
   parameter Real D13r = Aux[1,19];
   parameter Real D13i = Aux[1,20];
   parameter Real D21r = Aux[1,21];
   parameter Real D21i = Aux[1,22];
   parameter Real D22r = Aux[1,23];
   parameter Real D22i = Aux[1,24];
   parameter Real D23r = Aux[1,25];
   parameter Real D23i = Aux[1,26];
   parameter Real D31r = Aux[1,27];
   parameter Real D31i = Aux[1,28];
   parameter Real D32r = Aux[1,29];
   parameter Real D32i = Aux[1,30];
   parameter Real D33r = Aux[1,31];
   parameter Real D33i = Aux[1,32];

  
  equation
 // Equations related to the MonoxTri interface
  p.ir = Ar*p.vr-Ai*p.vi + MB1r*A.vr-MB1i*A.vi + MB2r*B.vr-MB2i*B.vi + MB3r*C.vr-MB3i*C.vi;
  p.ii = Ar*p.vi+Ai*p.vr + MB1r*A.vi+MB1i*A.vr + MB2r*B.vi+MB2i*B.vr + MB3r*C.vi+MB3i*C.vr;
  A.ir = C1r*p.vr-C1i*p.vi + D11r*A.vr-D11i*A.vi + D12r*B.vr-D12i*B.vi + D13r*C.vr-D13i*C.vi;
  A.ii = C1r*p.vi+C1i*p.vr + D11r*A.vi+D11i*A.vr + D12r*B.vi+D12i*B.vr + D13r*C.vi+D13i*C.vr;
  B.ir = C2r*p.vr-C2i*p.vi + D21r*A.vr-D21i*A.vi + D22r*B.vr-D22i*B.vi + D23r*C.vr-D23i*C.vi;
  B.ii = C2r*p.vi+C2i*p.vr + D21r*A.vi+D21i*A.vr + D22r*B.vi+D22i*B.vr + D23r*C.vi+D23i*C.vr;
  C.ir = C3r*p.vr-C3i*p.vi + D31r*A.vr-D31i*A.vi + D32r*B.vr-D32i*B.vi + D33r*C.vr-D33i*C.vi;
  C.ii = C3r*p.vi+C3i*p.vr + D31r*A.vi+D31i*A.vr + D32r*B.vi+D32i*B.vr + D33r*C.vi+D33i*C.vr;

    annotation (
    Icon(coordinateSystem(
        extent={{-80,-100},{80,100}},
        preserveAspectRatio=true,
        initialScale=0.1), graphics={Rectangle(
          extent={{-79,40},{79,-40}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Rectangle(
          extent={{-40,10},{40,-10}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),Line(
          points={{100,0},{79,0}},
          color={0,0,255},
          smooth=Smooth.None),Line(
          points={{-100,0},{-79,0}},
          color={0,0,255},
          smooth=Smooth.None),Line(
          points={{100,90},{79,40}},
          color={0,0,255},
          smooth=Smooth.None),Line(
          points={{100,-90},{79,-40}},
          color={0,0,255},
          smooth=Smooth.None)}),
    Diagram(coordinateSystem(
        extent={{-60,-40},{60,40}},
        preserveAspectRatio=true,
        initialScale=0.1)),
    uses(Modelica(version="3.2.1")),
    Documentation(revisions="<html>
<!--DISCLAIMER-->
<p>Copyright 2015-2016 RTE (France), SmarTS Lab (Sweden), AIA (Spain) and DTU (Denmark)</p>
<ul>
<li>RTE: <a href=\"http://www.rte-france.com\">http://www.rte-france.com</a></li>
<li>SmarTS Lab, research group at KTH: <a href=\"https://www.kth.se/en\">https://www.kth.se/en</a></li>
<li>AIA: <a href=\"http://www.aia.es/en/energy\"> http://www.aia.es/en/energy</a></li>
<li>DTU: <a href=\"http://www.dtu.dk/english\"> http://www.dtu.dk/english</a></li>
</ul>
<p>The authors can be contacted by email: <a href=\"mailto:info@itesla-ipsl.org\">info@itesla-ipsl.org</a></p>

<p>This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. </p>
<p>If a copy of the MPL was not distributed with this file, You can obtain one at <a href=\"http://mozilla.org/MPL/2.0/\"> http://mozilla.org/MPL/2.0</a>.</p>
</html>"));
end Line_MT;