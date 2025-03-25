competitor(sumsum,appy).
developed_smart_phone(sumsum,galactica-s3).
stole(galactica-s3,stevey).
boss(appy,stevey).

unethical(X) :- boss(Company,X), competitor(Competitor,Company),developed_smart_phone(Competitor,Technology),stole(Technology,X).

