/*!
 *
 * Bryntum Gantt 5.6.10 (TRIAL VERSION)
 *
 * Copyright(c) 2024 Bryntum AB
 * https://bryntum.com/contact
 * https://bryntum.com/license
 *
 */
(function(p,i){var l=typeof exports=="object";if(typeof define=="function"&&define.amd)define([],i);else if(typeof module=="object"&&module.exports)module.exports=i();else{var c=i(),j=l?exports:p;for(var m in c)j[m]=c[m]}})(typeof self<"u"?self:void 0,()=>{var p={},i={exports:p},l=Object.defineProperty,c=Object.getOwnPropertyDescriptor,j=Object.getOwnPropertyNames,m=Object.prototype.hasOwnProperty,g=(e,a,o)=>a in e?l(e,a,{enumerable:!0,configurable:!0,writable:!0,value:o}):e[a]=o,b=(e,a)=>{for(var o in a)l(e,o,{get:a[o],enumerable:!0})},D=(e,a,o,t)=>{if(a&&typeof a=="object"||typeof a=="function")for(let n of j(a))!m.call(e,n)&&n!==o&&l(e,n,{get:()=>a[n],enumerable:!(t=c(a,n))||t.enumerable});return e},y=e=>D(l({},"__esModule",{value:!0}),e),h=(e,a,o)=>(g(e,typeof a!="symbol"?a+"":a,o),o),v={};b(v,{default:()=>N}),i.exports=y(v);var s=typeof self<"u"?self:typeof globalThis<"u"?globalThis:null,k=class u{static mergeLocales(...a){let o={};return a.forEach(t=>{Object.keys(t).forEach(n=>{typeof t[n]=="object"?o[n]={...o[n],...t[n]}:o[n]=t[n]})}),o}static trimLocale(a,o){let t=(n,r)=>{a[n]&&(r?a[n][r]&&delete a[n][r]:delete a[n])};Object.keys(o).forEach(n=>{Object.keys(o[n]).length>0?Object.keys(o[n]).forEach(r=>t(n,r)):t(n)})}static normalizeLocale(a,o){if(!a)throw new Error('"nameOrConfig" parameter can not be empty');if(typeof a=="string"){if(!o)throw new Error('"config" parameter can not be empty');o.locale?o.name=a||o.name:o.localeName=a}else o=a;let t={};if(o.name||o.locale)t=Object.assign({localeName:o.name},o.locale),o.desc&&(t.localeDesc=o.desc),o.code&&(t.localeCode=o.code),o.path&&(t.localePath=o.path);else{if(!o.localeName)throw new Error(`"config" parameter doesn't have "localeName" property`);t=Object.assign({},o)}for(let n of["name","desc","code","path"])t[n]&&delete t[n];if(!t.localeName)throw new Error("Locale name can not be empty");return t}static get locales(){return s.bryntum.locales||{}}static set locales(a){s.bryntum.locales=a}static get localeName(){return s.bryntum.locale||"En"}static set localeName(a){s.bryntum.locale=a||u.localeName}static get locale(){return u.localeName&&this.locales[u.localeName]||this.locales.En||Object.values(this.locales)[0]||{localeName:"",localeDesc:"",localeCoode:""}}static publishLocale(a,o){let{locales:t}=s.bryntum,n=u.normalizeLocale(a,o),{localeName:r}=n;return!t[r]||o===!0?t[r]=n:t[r]=this.mergeLocales(t[r]||{},n||{}),t[r]}};h(k,"skipLocaleIntegrityCheck",!1);var d=k;s.bryntum=s.bryntum||{},s.bryntum.locales=s.bryntum.locales||{},d._$name="LocaleHelper";var S={localeName:"Sr",localeDesc:"Srpski",localeCode:"sr",RemoveDependencyCycleEffectResolution:{descriptionTpl:"Ukloni zavisnost"},DeactivateDependencyCycleEffectResolution:{descriptionTpl:"Deaktiviraj zavisnost"},CycleEffectDescription:{descriptionTpl:"Pronađen je ciklus, koji je kreirao: {0}"},EmptyCalendarEffectDescription:{descriptionTpl:'"{0}" Kalendar ne pruža radne vremenske intervale.'},Use24hrsEmptyCalendarEffectResolution:{descriptionTpl:"Koristi 24-časovni kalendar za neradne subote i nedelje."},Use8hrsEmptyCalendarEffectResolution:{descriptionTpl:"Koristi 8-časovni kalendar (08.00-12-00, 13.00-17.00) za neradne subote i nedelje."},IgnoreProjectConstraintResolution:{descriptionTpl:"Zanemarite granicu projekta i nastavite sa promenom."},ProjectConstraintConflictEffectDescription:{startDescriptionTpl:"Premestili ste zadatak „{0}“ da biste pokrenuli {1}. Ovo je pre datuma početka projekta {2}.",endDescriptionTpl:"Premestili ste zadatak „{0}“ da biste završili {1}. Ovo je posle datuma završetka projekta {2}."},HonorProjectConstraintResolution:{descriptionTpl:"Prilagodite zadatak da poštuje granicu projekta."},ConflictEffectDescription:{descriptionTpl:"Pronađen je konflikt u rasporedu: {0} je u konfliktu sa {1}"},ConstraintIntervalDescription:{dateFormat:"LLL"},ProjectConstraintIntervalDescription:{startDateDescriptionTpl:"Datum početka projekta {0}",endDateDescriptionTpl:"Datum završetka projekta {0}"},DependencyType:{long:["Od početka do početka","Od početka do kraja","Od kraja do početka","Od kraja do kraja"]},ManuallyScheduledParentConstraintIntervalDescription:{startDescriptionTpl:'Ručni raspored "{2}" primorava svoje zavisne događaje da počnu ne ranije od {0}',endDescriptionTpl:'Ručni raspored "{2}" primorava svoje zavisne događaje da završe ne ranije od {1}'},DisableManuallyScheduledConflictResolution:{descriptionTpl:'Onemogući ručno raspoređivanje za "{0}"'},DependencyConstraintIntervalDescription:{descriptionTpl:'Zavisnost ({2}) od "{3}" do "{4}"'},RemoveDependencyResolution:{descriptionTpl:'Ukloni zavisnost od "{1}" do "{2}"'},DeactivateDependencyResolution:{descriptionTpl:'Deaktiviraj zavisnost "{1}" do "{2}"'},DateConstraintIntervalDescription:{startDateDescriptionTpl:'Zadatak "{2}" {3} {0} ograničenje',endDateDescriptionTpl:'Zadatak "{2}" {3} {1} ograničenje',constraintTypeTpl:{startnoearlierthan:"Počni ne ranije od",finishnoearlierthan:"Završi ne ranije od",muststarton:"Mora da počne",mustfinishon:"Mora da se završi",startnolaterthan:"Počni ne kasnije od",finishnolaterthan:"Završi ne kasnije od"}},RemoveDateConstraintConflictResolution:{descriptionTpl:'Ukloni "{1}" ograničenje zadatka "{0}"'}},R=d.publishLocale(S),P={localeName:"Sr",localeDesc:"Srpski",localeCode:"sr",Object:{Yes:"Da",No:"Ne",Cancel:"Otkaži",Ok:"OK",Week:"Nedelja",None:"Ништа"},ColorPicker:{noColor:"Без боје"},Combo:{noResults:"Nema rezultata",recordNotCommitted:"Rezultati nisu mogli biti dodati",addNewValue:e=>`Dodaj ${e}`},FilePicker:{file:"Datoteka"},Field:{badInput:"Neispravna vrednost polja",patternMismatch:"Vrednost treba da odgovara određenom šablonu",rangeOverflow:e=>`Vrednost mora biti manja ili jednaka ${e.max}`,rangeUnderflow:e=>`Vrednost mora biti veća ili jednaka ${e.min}`,stepMismatch:"Vrednost treba da odgovara koraku",tooLong:"Vrednost treba da je kraća",tooShort:"Vrednost treba da je duža",typeMismatch:"Potrebno je da vrednost bude određenog formata",valueMissing:"Ovo polje je potrebno",invalidValue:"Neispravna vrednost polja",minimumValueViolation:"Minimalna vrednost prekršaja",maximumValueViolation:"Maksimalna vrednost prekršaja",fieldRequired:"Ovo polje je potrebno",validateFilter:"Vrednost mora da bude izabrana sa liste"},DateField:{invalidDate:"Neispravni unos datuma"},DatePicker:{gotoPrevYear:"Idi na prethodnu godinu",gotoPrevMonth:"Idi na prethodni mesec",gotoNextMonth:"Idi na sledeći mesec",gotoNextYear:"Idi na sledeću godinu"},NumberFormat:{locale:"sr",currency:"RSD"},DurationField:{invalidUnit:"Neispravna jedinica"},TimeField:{invalidTime:"Neispravan unos vremena"},TimePicker:{hour:"Sat",minute:"Minut",second:"Sekunda"},List:{loading:"Učitavanje...",selectAll:"Odaberi sve"},GridBase:{loadMask:"Učitavanje...",syncMask:"Promene se čuvaju, molim sačekajte..."},PagingToolbar:{firstPage:"Idi na prvu stranu",prevPage:"Idi na prethodnu stranu",page:"Strana",nextPage:"Idi na sledeću stranu",lastPage:"Idi na poslednju stranu",reload:"Ponovo učitaj trenutnu stranu",noRecords:"Nema zapisa za prikaz",pageCountTemplate:e=>`od ${e.lastPage}`,summaryTemplate:e=>`Prikazuju se zapisi ${e.start} - ${e.end} od ${e.allCount}`},PanelCollapser:{Collapse:"Skupi",Expand:"Raširi"},Popup:{close:"Zatvori iskačući prozor"},UndoRedo:{Undo:"Opozovi",Redo:"Ponovi",UndoLastAction:"Opozovi poslednju radnju",RedoLastAction:"Ponovi poslednju opozvanu radnju",NoActions:"Nema stavki u redu za opoziv"},FieldFilterPicker:{equals:"jednako",doesNotEqual:"nije jednako",isEmpty:"je prazno",isNotEmpty:"nije prazno",contains:"sadrži",doesNotContain:"ne sadrži",startsWith:"počinje sa",endsWith:"završava sa",isOneOf:"je jedan od",isNotOneOf:"nije jedan od",isGreaterThan:"je veći od",isLessThan:"je manji od",isGreaterThanOrEqualTo:"je veći ili jednak od",isLessThanOrEqualTo:"je manji ili jednak od",isBetween:"je između",isNotBetween:"nije između",isBefore:"je pre",isAfter:"je posle",isToday:"je danas",isTomorrow:"je sutra",isYesterday:"je juče",isThisWeek:"je ove nedelje",isNextWeek:"je sledeće nedelje",isLastWeek:"je prošle nedelje",isThisMonth:"je ovog meseca",isNextMonth:"je sledećeg meseca",isLastMonth:"je prošlog meseca",isThisYear:"je ove godine",isNextYear:"je sledeće godine",isLastYear:"je prošle godine",isYearToDate:"je od početka godine do danas",isTrue:"je tačan",isFalse:"je netačan",selectAProperty:"Izaberite svojstvo",selectAnOperator:"Izaberite operatora",caseSensitive:"Osetljivo na mala i velika slova",and:"i",dateFormat:"D/M/YY",selectValue:"Izaberite vrednost",selectOneOrMoreValues:"Izaberite jednu ili više vrednosti",enterAValue:"Unesite vrednost",enterANumber:"Unesite broj",selectADate:"Izaberite datum",selectATime:"Izaberite vreme"},FieldFilterPickerGroup:{addFilter:"Dodajte filter"},DateHelper:{locale:"sr",weekStartDay:1,nonWorkingDays:{0:!0,6:!0},weekends:{0:!0,6:!0},unitNames:[{single:"milisekund",plural:"milisekundi",abbrev:"ms"},{single:"sekunda",plural:"sekunde",abbrev:"s"},{single:"minut",plural:"minuta",abbrev:"min"},{single:"sat",plural:"sati",abbrev:""},{single:"dan",plural:"dana",abbrev:"d"},{single:"nedelja",plural:"nedelje",abbrev:"ned"},{single:"mesec",plural:"meseci",abbrev:"mes"},{single:"kvartal",plural:"kvartala",abbrev:"kv"},{single:"godina",plural:"godine",abbrev:"god"},{single:"dekada",plural:"dekade",abbrev:"dek"}],unitAbbreviations:[["ms"],["s","sek"],["m","min"],["sat","sati"],["d"],["ned","ned"],["mes","mes","mes"],["kv","kv","kv"],["g","god"],["dek"]],parsers:{L:"D.M.YYYY",LT:"HH:mm",LTS:"HH:mm:ss A"},ordinalSuffix:e=>e+"."}},M=d.publishLocale(P),f=new String,C={localeName:"Sr",localeDesc:"Srpski",localeCode:"sr",ColumnPicker:{column:"Kolona",columnsMenu:"Kolone",hideColumn:"Sakrij kolonu",hideColumnShort:"Sakrij",newColumns:"Nove kolone"},Filter:{applyFilter:"Primeni filter",filter:"Filter",editFilter:"Uredi filter",on:"Uključeno",before:"Pre",after:"Posle",equals:"Jednako",lessThan:"Manje od",moreThan:"Više od",removeFilter:"Ukloni filter",disableFilter:"Onemogući filter"},FilterBar:{enableFilterBar:"Prikaži traku sa filterima",disableFilterBar:"Sakrij traku sa filterima"},Group:{group:"Grupiši",groupAscending:"Grupiši uzlazno",groupDescending:"Grupiši silazno",groupAscendingShort:"Uzlazno",groupDescendingShort:"Silazno",stopGrouping:"Prekini grupisanje",stopGroupingShort:"Stani"},HeaderMenu:{moveBefore:e=>`Pomeri pre "${e}"`,moveAfter:e=>`Pomeri posle "${e}"`,collapseColumn:"Skupi kolonu",expandColumn:"Proširi kolonu"},ColumnRename:{rename:"Preimenuj"},MergeCells:{mergeCells:"Spoj ćelije",menuTooltip:"Spoj ćelije sa istim vrednostima sortirane prema ovoj koloni"},Search:{searchForValue:"Pretraži vrednost"},Sort:{sort:"Sortiraj",sortAscending:"Sortiraj uzlazno",sortDescending:"Sortiraj silazno",multiSort:"Višestruko sortiranje",removeSorter:"Ukloni sortiranje",addSortAscending:"Dodaj uzlazno sortiranje",addSortDescending:"Dodaj silazno sortiranje",toggleSortAscending:"Promeni u uzlazno",toggleSortDescending:"Promeni u sliazno",sortAscendingShort:"Uzlazno",sortDescendingShort:"Silazno",removeSorterShort:"Ukloni",addSortAscendingShort:"+ Uzlazno",addSortDescendingShort:"+ Silazno"},Split:{split:"Podeljeno",unsplit:"Nepodeljeno",horizontally:"Horizontalno",vertically:"Vertikalno",both:"Oboje"},Column:{columnLabel:e=>`${e.text?`${e.text} kolone. `:""}SPACE za kontekstni meni${e.sortable?", ENTER za sortiranje":""}`,cellLabel:f},Checkbox:{toggleRowSelect:"Naizmenični izbor reda",toggleSelection:"Naizmenični izbor kompletnog seta podataka"},RatingColumn:{cellLabel:e=>{var a;return`${e.text?e.text:""} ${(a=e.location)!=null&&a.record?`ocena : ${e.location.record.get(e.field)||0}`:""}`}},GridBase:{loadFailedMessage:"Učitavanje podataka nije uspelo!",syncFailedMessage:"Sinhronizacija podataka nije uspela!",unspecifiedFailure:"Neodređena greška",networkFailure:"Greška mreže",parseFailure:"Raščlanjivanje odgovora servera nije uspelo",serverResponse:"Odgovor servera:",noRows:"Nema zapisa za prikaz",moveColumnLeft:"Pomeri u levi odeljak",moveColumnRight:"Pomeri u desni odeljak",moveColumnTo:e=>`Pomeri kolonu u ${e}`},CellMenu:{removeRow:"Obriši"},RowCopyPaste:{copyRecord:"Kopiraj",cutRecord:"Iseci",pasteRecord:"Umetni",rows:"redova",row:"red"},CellCopyPaste:{copy:"Kopiraj",cut:"Iseci",paste:"Umetni"},PdfExport:{"Waiting for response from server":"Čeka se na odgovor servera...","Export failed":"Izvoz nije uspeo","Server error":"Greška servera","Generating pages":"Generišem stranice...","Click to abort":"Otkaži"},ExportDialog:{width:"40em",labelWidth:"12em",exportSettings:"Izvezi podešavanja",export:"Izvezi",printSettings:"Postavke štampe",print:"Štampa",exporterType:"Kontrola straničenja",cancel:"Otkaži",fileFormat:"Format datoteke",rows:"Redovi",alignRows:"Poravnaj redove",columns:"Kolone",paperFormat:"Format papira",orientation:"Orijentacija",repeatHeader:"Ponovi zaglavlje"},ExportRowsCombo:{all:"Svi redovi",visible:"Vidljivi redovi"},ExportOrientationCombo:{portrait:"Upravno",landscape:"Položeno"},SinglePageExporter:{singlepage:"Jedna strana"},MultiPageExporter:{multipage:"Više strana",exportingPage:({currentPage:e,totalPages:a})=>`Izvos stranice ${e}/${a}`},MultiPageVerticalExporter:{multipagevertical:"Više strana (uspravno)",exportingPage:({currentPage:e,totalPages:a})=>` Izvos stranice ${e}/${a}`},RowExpander:{loading:"Učitavanje",expand:"Raširi",collapse:"Skupi"},TreeGroup:{group:"Grupiši po",stopGrouping:"Prekini grupisanje",stopGroupingThisColumn:"Prekini grupisanje ove kolone"}},I=d.publishLocale(C),T={localeName:"Sr",localeDesc:"Srpski",localeCode:"sr",Object:{newEvent:"Novi dogđaj"},ResourceInfoColumn:{eventCountText:e=>e+" dogđaj"+(e!==1?"događaji":"i")},Dependencies:{from:"Od",to:"Do",valid:"Ispravan",invalid:"Neispravan"},DependencyType:{SS:"PP",SF:"PK",FS:"KP",FF:"KK",StartToStart:"Od početka do početka",StartToEnd:"Od početka do kraja",EndToStart:"Od kraja do početka",EndToEnd:"Od kraja do kraja",short:["PP","PK","KP","KK"],long:["Od početka do početka","Od početka do kraja","Od kraja do početka","Od kraja do kraja"]},DependencyEdit:{From:"Od",To:"Do",Type:"Tip",Lag:"Kašnjenje","Edit dependency":"Uredi zavisnost",Save:"Sačuvaj",Delete:"Obriši",Cancel:"Otkaži",StartToStart:"Od početka do početka",StartToEnd:"Od početka do kraja",EndToStart:"Od kraja do početka",EndToEnd:"Od kraja do kraja"},EventEdit:{Name:"Ime",Resource:"Resurs",Start:"Početak",End:"Kraj",Save:"Sačuvaj",Delete:"Obriši",Cancel:"Otkaži","Edit event":"Uredi događaj",Repeat:"Ponovi"},EventDrag:{eventOverlapsExisting:"Događaj preklapa postojeći događaj za ovaj resurs",noDropOutsideTimeline:"Događaj možda nije u potpunosti spušten izvan vremenske linije"},SchedulerBase:{"Add event":"Dodaj događaj","Delete event":"Obriši događaj","Unassign event":"Poništi dodelu događaja",color:"Boja"},TimeAxisHeaderMenu:{pickZoomLevel:"Zumiranje",activeDateRange:"Opseg datuma",startText:"Početni datum",endText:"Krajnji datum",todayText:"Danas"},EventCopyPaste:{copyEvent:"Kopiraj događaj",cutEvent:"Iseci događaj",pasteEvent:"Umetni događaj"},EventFilter:{filterEvents:"Filtriraj zadatke",byName:"Po imenu"},TimeRanges:{showCurrentTimeLine:"Prikaži trenutnu vremensku liniju"},PresetManager:{secondAndMinute:{displayDateFormat:"ll LTS",name:"Sekundi"},minuteAndHour:{topDateFormat:"ddd D.M., hA",displayDateFormat:"ll LST"},hourAndDay:{topDateFormat:"ddd D.M.",middleDateFormat:"LST",displayDateFormat:"ll LST",name:"Dan"},day:{name:"Dan/sati"},week:{name:"Nedelja/sati"},dayAndWeek:{displayDateFormat:"ll LST",name:"Nedelja/dana"},dayAndMonth:{name:"Mesec"},weekAndDay:{displayDateFormat:"ll LST",name:"Nedelja"},weekAndMonth:{name:"Nedelja"},weekAndDayLetter:{name:"Nedelja/radnih dana"},weekDateAndMonth:{name:"Meseci/nedelja"},monthAndYear:{name:"Meseci"},year:{name:"Godina"},manyYears:{name:"Više godina"}},RecurrenceConfirmationPopup:{"delete-title":"Brisanje događaja","delete-all-message":"Da li želišda obrišeš sva pojavljivanja ovog događaja?","delete-further-message":"Da li želiš da obrišeš ovaj i sva sledeća pojavljivanja ovog događaja, ili samo odabrano pojavljivanje?","delete-further-btn-text":"Obriši sve buduće događaje","delete-only-this-btn-text":"Obriši samo ovaj događaj","update-title":"Izmena događaja koji se ponavlja","update-all-message":"Da li želiš da promeniš sva pojavljivanja ovog događaja?","update-further-message":"Da li želiš da promeniš samo ovo pojavljivanje događaja, ili ovo i svako buduće pojavljivanje? ","update-further-btn-text":"Sve buduće događaje","update-only-this-btn-text":"Samo ovaj događaj",Yes:"Da",Cancel:"Otkaži",width:600},RecurrenceLegend:{" and ":" i ",Daily:"Dnevno","Weekly on {1}":({days:e})=>`Svake nedelje u ${e}`,"Monthly on {1}":({days:e})=>`Svakog meseca u ${e}`,"Yearly on {1} of {2}":({days:e,months:a})=>`Svake godine u ${e} u ${a}`,"Every {0} days":({interval:e})=>`Svakih ${e} dana`,"Every {0} weeks on {1}":({interval:e,days:a})=>`Svakih ${e} nedelja u ${a}`,"Every {0} months on {1}":({interval:e,days:a})=>`Svakih ${e} meseci u ${a}`,"Every {0} years on {1} of {2}":({interval:e,days:a,months:o})=>`Svakih ${e} godina na ${a} u ${o}`,position1:"prvi",position2:"drugi",position3:"treći",position4:"četvrti",position5:"peti","position-1":"poslednji",day:"dan",weekday:"radni dan","weekend day":"dan vikenda",daysFormat:({position:e,days:a})=>`${e} ${a}`},RecurrenceEditor:{"Repeat event":"Ponovi događaj",Cancel:"Otkaži",Save:"Sačuvaj",Frequency:"Frekvencija",Every:"Svaki(h)",DAILYintervalUnit:"dan(a)",WEEKLYintervalUnit:"nedelje(e)",MONTHLYintervalUnit:"mesec(a)",YEARLYintervalUnit:"godina(e)",Each:"Svake","On the":"Na","End repeat":"Kraj ponavljanja","time(s)":"put(a)"},RecurrenceDaysCombo:{day:"dan",weekday:"radni dan","weekend day":"dan vikenda"},RecurrencePositionsCombo:{position1:"prvi",position2:"drugi",position3:"treći",position4:"četvrti",position5:"peti","position-1":"poslednji"},RecurrenceStopConditionCombo:{Never:"Nikad",After:"Nakon","On date":"Na dan"},RecurrenceFrequencyCombo:{None:"Bez ponavljanja",Daily:"Dnevno",Weekly:"Nedeljno",Monthly:"Mesečno",Yearly:"Godišnje"},RecurrenceCombo:{None:"Nema",Custom:"Prilagođeno…"},Summary:{"Summary for":e=>`Pregled na ${e}`},ScheduleRangeCombo:{completeview:"Kompletan raspored",currentview:"Vidljiv raspored",daterange:"Opseg datuma",completedata:"Kompletan raspored (za sve događaje)"},SchedulerExportDialog:{"Schedule range":"Opseg rasporeda","Export from":"Od","Export to":"Do"},ExcelExporter:{"No resource assigned":"Nema pridruženih resursa"},CrudManagerView:{serverResponseLabel:"Odgovor servera:"},DurationColumn:{Duration:"Trajanje"}},F=d.publishLocale(T),z={localeName:"Sr",localeDesc:"Srpski",localeCode:"sr",ConstraintTypePicker:{none:"Nema",assoonaspossible:"Što je pre moguće",aslateaspossible:"Što je kasnije moguće",muststarton:"Mora da počne",mustfinishon:"Mora da se završi",startnoearlierthan:"Počni ne ranije od",startnolaterthan:"Počni ne kasnije od",finishnoearlierthan:"Završi ne ranije od",finishnolaterthan:"Završi ne kasnije od"},SchedulingDirectionPicker:{Forward:"Napred",Backward:"Nazad",inheritedFrom:"Наслеђено од",enforcedBy:"Намеће"},CalendarField:{"Default calendar":"Podrazumevani kalendar"},TaskEditorBase:{Information:"Informacija",Save:"Sačuvaj",Cancel:"Otkaži",Delete:"Obriši",calculateMask:"Računam...",saveError:"Nije moguće sačuvati, najpre ispravi greške",repeatingInfo:"Gledate događaj koji se ponavlja",editRepeating:"Uredi"},TaskEdit:{editEvent:"Uredi događaj",ConfirmDeletionTitle:"Potvrda brisanja",ConfirmDeletionMessage:"Sigurno želiš da obrišeš ovaj događaj?"},GanttTaskEditor:{editorWidth:"45em"},SchedulerTaskEditor:{editorWidth:"35em"},SchedulerGeneralTab:{labelWidth:"6em",General:"Opšte",Name:"Ime",Resources:"Resursi","% complete":"% dovršeno",Duration:"Trajanje",Start:"Početak",Finish:"Kraj",Effort:"Trud",Preamble:"Uvod",Postamble:"Posle uvoda"},GeneralTab:{labelWidth:"6.5em",General:"Opšte",Name:"Ime","% complete":"% dovršeno",Duration:"Trajanje",Start:"Početak",Finish:"Kraj",Effort:"Trud",Dates:"Datumi"},SchedulerAdvancedTab:{labelWidth:"13em",Advanced:"Napredno",Calendar:"Kalendar","Scheduling mode":"Režim planiranja","Effort driven":"Gonjeno trudom","Manually scheduled":"Ručno planirano","Constraint type":"Tip ograničenja","Constraint date":"Datum ograničenja",Inactive:"Neaktivan","Ignore resource calendar":"Ignoriši kalendar resursa"},AdvancedTab:{labelWidth:"11.5em",Advanced:"Napredno",Calendar:"Kalendar","Scheduling mode":"Režim planiranja","Effort driven":"Gonjeno trudom","Manually scheduled":"Ručno planirano","Constraint type":"Tip ograničenja","Constraint date":"Datum ograničenja",Constraint:"Ograničenje",Rollup:"Postignuće",Inactive:"Neaktivan","Ignore resource calendar":"Ignoriši kalendar resursa","Scheduling direction":"Smer planiranja",projectBorder:"Granica projekta",ignore:"Ignoriraj",honor:"Čast",askUser:"Pitajte korisnika"},DependencyTab:{Predecessors:"Prethodnici",Successors:"Naslednici",ID:"ID",Name:"Ime",Type:"Tipe",Lag:"Kašnjenje",cyclicDependency:"Ciklična zavisnost",invalidDependency:"Neispravna zavisnost"},NotesTab:{Notes:"Beleške"},ResourcesTab:{unitsTpl:({value:e})=>`${e}%`,Resources:"Resursi",Resource:"Resurs",Units:"Jedinice"},RecurrenceTab:{title:"Sa ponavljanjem"},SchedulingModePicker:{Normal:"Normalni","Fixed Duration":"Fiksno trajanje","Fixed Units":"Fiksne jedinice","Fixed Effort":"Fiksni trud"},ResourceHistogram:{barTipInRange:'<b>{resource}</b> {startDate} - {endDate}<br><span class="{cls}">{allocated} od {available}</span> dodeljeno',barTipOnDate:'<b>{resource}</b> on {startDate}<br><span class="{cls}">{allocated} od {available}</span> dodeljeno',groupBarTipAssignment:'<b>{resource}</b> - <span class="{cls}">{allocated} od {available}</span>',groupBarTipInRange:'{startDate} - {endDate}<br><span class="{cls}">{allocated} od {available}</span> allocated:<br>{assignments}',groupBarTipOnDate:'Dana {startDate}<br><span class="{cls}">{allocated} od {available}</span> dodeljeno:<br>{assignments}',plusMore:"+{value} više"},ResourceUtilization:{barTipInRange:'<b>{event}</b> {startDate} - {endDate}<br><span class="{cls}">{allocated}</span> dodeljeno',barTipOnDate:'<b>{event}</b> on {startDate}<br><span class="{cls}">{allocated}</span> dodeljeno',groupBarTipAssignment:'<b>{event}</b> - <span class="{cls}">{allocated}</span>',groupBarTipInRange:'{startDate} - {endDate}<br><span class="{cls}">{allocated} od {available}</span> dodeljeno:<br>{assignments}',groupBarTipOnDate:'Dana {startDate}<br><span class="{cls}">{allocated} od {available}</span> dodeljeno:<br>{assignments}',plusMore:"+{value} više",nameColumnText:"Resurs / Događaj"},SchedulingIssueResolutionPopup:{"Cancel changes":"Otkaži promenu i ne radi ništa",schedulingConflict:"Konflikt pri planiranju",emptyCalendar:"Greška u konfiguraciji kalendara",cycle:"Ciklus planiranja",Apply:"Primeni"},CycleResolutionPopup:{dependencyLabel:"Iaberitzavisnost:",invalidDependencyLabel:"Postoje neispravne zavisnosti koje moraš da popraviš:"},DependencyEdit:{Active:"Aktivna"},SchedulerProBase:{propagating:"Proračunavam projekat",storePopulation:"Učitavam podatke",finalizing:"Završavam rezultate"},EventSegments:{splitEvent:"Podeli događaj",renameSegment:"Preimenuj"},NestedEvents:{deNestingNotAllowed:"Uklanjanje iz ugnežđivanja nije dozvoljeno",nestingNotAllowed:"Ugnežđivanje nije dozvoljeno"},VersionGrid:{compare:"Uporedi",description:"Opis",occurredAt:"Dogodilo se u",rename:"Preimenuj",restore:"Vrati",stopComparing:"Zaustavi upoređivanje"},Versions:{entityNames:{TaskModel:"zadatak",AssignmentModel:"zaduženje",DependencyModel:"veza",ProjectModel:"projekat",ResourceModel:"resurs",other:"objekat"},entityNamesPlural:{TaskModel:"zadaci",AssignmentModel:"zaduženja",DependencyModel:"veze",ProjectModel:"projekti",ResourceModel:"resursi",other:"objekti"},transactionDescriptions:{update:"Promenjeno {n} {entities}",add:"Dodato {n} {entities}",remove:"Uklonjeno {n} {entities}",move:"Pomereno {n} {entities}",mixed:"Promenjeno {n} {entities}"},addEntity:"Dodato {type} **{name}**",removeEntity:"Uklonjeno {type} **{name}**",updateEntity:"Promenjeno {type} **{name}**",moveEntity:"Pomereno {type} **{name}** od {from} do {to}",addDependency:"Dodata veza od **{from}** do **{to}**",removeDependency:"Uklonjena veza od **{from}** do **{to}**",updateDependency:"Izmenjena veza od **{from}** do **{to}**",addAssignment:"Dodeljen **{resource}** na **{event}**",removeAssignment:"Uklonjen zadatak sa **{resource}** od **{event}**",updateAssignment:"Izmenjen zadatak sa **{resource}** na **{event}**",noChanges:"Nema promena",nullValue:"nema",versionDateFormat:"M/D/YYYY h:mm a",undid:"Vraćene promene",redid:"Ponovo primenjene promene",editedTask:"Izmeni svojstva zadatka",deletedTask:"Obrisan zadatak",movedTask:"Pomeren zadatak",movedTasks:"Pomereni zadaci"}},w=d.publishLocale(z),E={localeName:"Sr",localeDesc:"Srpski",localeCode:"sr",Object:{Save:"Sačuvaj"},IgnoreResourceCalendarColumn:{"Ignore resource calendar":"Ignoriši kalendar resursa"},InactiveColumn:{Inactive:"Neaktivan"},AddNewColumn:{"New Column":"Nova kolona"},BaselineStartDateColumn:{baselineStart:"Originalni datum početka"},BaselineEndDateColumn:{baselineEnd:"Originalni datum završetak"},BaselineDurationColumn:{baselineDuration:"Originalni trajanje"},BaselineStartVarianceColumn:{startVariance:"Odstupanje od datuma početka"},BaselineEndVarianceColumn:{endVariance:"Odstupanje od datuma završetak"},BaselineDurationVarianceColumn:{durationVariance:"Varijansa trajanja"},CalendarColumn:{Calendar:"Kalendar"},EarlyStartDateColumn:{"Early Start":"Rani početak"},EarlyEndDateColumn:{"Early End":"Rani završetak"},LateStartDateColumn:{"Late Start":"Kasni početak"},LateEndDateColumn:{"Late End":"Kasni završetak"},TotalSlackColumn:{"Total Slack":"Ukupno kašnjenje"},ConstraintDateColumn:{"Constraint Date":"Datum ograničenja"},ConstraintTypeColumn:{"Constraint Type":"Tip ograničenja"},DeadlineDateColumn:{Deadline:"Krajnji rok"},DependencyColumn:{"Invalid dependency":"Neispravna zavisnost"},DurationColumn:{Duration:"Trajanje"},EffortColumn:{Effort:"Trud"},EndDateColumn:{Finish:"Završetak"},EventModeColumn:{"Event mode":"Režim događaja",Manual:"Ručni",Auto:"Automatski"},ManuallyScheduledColumn:{"Manually scheduled":"Ručno planirano"},MilestoneColumn:{Milestone:"Prekretnica"},NameColumn:{Name:"Ime"},NoteColumn:{Note:"Napomena"},PercentDoneColumn:{"% Done":"% dovršeno"},PredecessorColumn:{Predecessors:"Prethodnici"},ResourceAssignmentColumn:{"Assigned Resources":"Dodeljeni resursi","more resources":"još resursa"},RollupColumn:{Rollup:"Postignuće"},SchedulingModeColumn:{"Scheduling Mode":"Režim planiranja"},SchedulingDirectionColumn:{schedulingDirection:"Смер планирања",inheritedFrom:"Наслеђено од",enforcedBy:"Намеће"},SequenceColumn:{Sequence:"Sekvenca"},ShowInTimelineColumn:{"Show in timeline":"Prikaži na vremenskoj liniji"},StartDateColumn:{Start:"Početak"},SuccessorColumn:{Successors:"Naslednici"},TaskCopyPaste:{copyTask:"Kopiraj",cutTask:"Iseci",pasteTask:"Nalepi"},WBSColumn:{WBS:"Pregled strukture rada",renumber:"Prenumerisanje"},DependencyField:{invalidDependencyFormat:"Neispravni format zavisnosti"},ProjectLines:{"Project Start":"Početak projekta","Project End":"Završetak projekta"},TaskTooltip:{Start:"Početak",End:"Kraj",Duration:"Trajanje",Complete:"Završen"},AssignmentGrid:{Name:"Ime resursa",Units:"Jedinice",unitsTpl:({value:e})=>e?e+"%":""},Gantt:{Edit:"Izmeni",Indent:"Uvuci",Outdent:"Izbaci","Convert to milestone":"Pretvori u prekretnicu",Add:"Dodaj...","New task":"Novi zadatak","New milestone":"Nova prekretnica","Task above":"Zadatak iznad","Task below":"Zadatak ispod","Delete task":"Obriši",Milestone:"Prekretnica","Sub-task":"Pod-zadatak",Successor:"Naslednik",Predecessor:"Prethodnik",changeRejected:"Projektni algoritam je odbio promene",linkTasks:"Dodaj zavisnosti",unlinkTasks:"Uklonite zavisnosti",color:"Boja"},EventSegments:{splitTask:"Podeli zadatak"},Indicators:{earlyDates:"Rani početak/završetak",lateDates:"Kasni početak/kraj",Start:"Početak",End:"Kraj",deadlineDate:"Krajnji rok"},Versions:{indented:"Uvučeno",outdented:"Izvučeno",cut:"Isečeno",pasted:"Umetnuto",deletedTasks:"Obrisani zadaci"}},N=d.publishLocale(E);if(typeof i.exports=="object"&&typeof p=="object"){var O=(e,a,o,t)=>{if(a&&typeof a=="object"||typeof a=="function")for(let n of Object.getOwnPropertyNames(a))!Object.prototype.hasOwnProperty.call(e,n)&&n!==o&&Object.defineProperty(e,n,{get:()=>a[n],enumerable:!(t=Object.getOwnPropertyDescriptor(a,n))||t.enumerable});return e};i.exports=O(i.exports,p)}return i.exports});