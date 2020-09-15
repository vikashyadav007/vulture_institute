var course=['cbse','pre-foundation','iit-jee','neet','other-competitive-exams','rbse'];
var medium = ['english','hindi'];
var standard = ['9','10','11','12','reet-sm','reet-sst','patwar',"13",'constable','highcourt-class4','highcourt-ldc'];
var subject = ['physics','chemistry','mathematics','biology','zoology','botney',
'hindi','english','psychology','science','India-gk','rajasthan-gk','reasoning','computer',
'India-gk-and-current-gk','kanuni-prabdhan','rajasthan-arts&culture',
];
var testOption = ['practice-test','aits'];

var paymentChoiceOption=['subject-wise','complete'];
var paymentSubjectOption=['11physics','11chemistry','11mathematics','11zoology','11botney','12physics','12chemistry','12mathematics','12zoology','12botney','science','gk','psychology','mathematics'];
var paymentDuration=['month','3month','6month','year','2year'];

var durationMap={
  'month':1,
  '3month':3,
  '6month':6,
  'year':12,
  '2year':24,
};

var subjectsMap={
  'neet':['physics','chemistry','zoology','botney'],
  'iit-jee':['physics','chemistry','mathematics'],
  'reet-sst':['hindi','english','India-gk','psychology','rajasthan-gk'],
  'reet-sm':['hindi','english','science','psychology','mathematics',],
  'patwar':['hindi','english','science','mathematics','reasoning','computer','rajasthan-gk','India-gk-and-current-gk'],
  'constable':['rajasthan-gk','India-gk','science','reasoning','kanuni-prabdhan','computer'],
  'highcourt-class4':['hindi','english','rajasthan-arts&culture'],
  'highcourt-ldc':['hindi','english','India-gk','rajasthan-gk'],
  'cbse':['physics','chemistry','mathematics'],
  'rbse':['physics','chemistry','mathematics'],
};

var menuChoice = ['Video Lectures','Study Material',"Test Series","Doubts","Test Series Solution","Live Class"];

const String VIDEOLECTURE = 'Video Lectuers';
const String STUDYMATERIAL = 'Study Material';
const String TESTSERIES =  'Test Series';

const STATUS_LOADING = "PAYMENT_LOADING";
const STATUS_SUCCESSFUL = "PAYMENT_SUCCESSFUL";
const STATUS_PENDING = "PAYMENT_PENDING";
const STATUS_FAILED = "PAYMENT_FAILED";
const STATUS_CHECKSUM_FAILED = "PAYMENT_CHECKSUM_FAILED";

const imageUrl = 'assets/logo2.png';