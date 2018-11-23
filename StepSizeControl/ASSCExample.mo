package ASSCExample

class Class1
  Modelica.Blocks.Interfaces.RealOutput max;//event indicator
  Real eventTime=2.3; //time indicator
  Real closeToMax; //dynamic threshold
  equation
  if time<eventTime then max=2; else max=5; end if;
  closeToMax=max-0.1;
end Class1;


class Class2
  Modelica.Blocks.Interfaces.RealInput max;
  Real signalwiththreshold; //critical signal
  initial equation
  signalwiththreshold=0;
  equation
  if (signalwiththreshold<max) then der(signalwiththreshold)=1; else der(signalwiththreshold)=0; end if;
end Class2;

end ASSCExample;
