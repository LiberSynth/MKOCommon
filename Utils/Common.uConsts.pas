unit Common.uConsts;

interface

uses
  { VCL }
  Winapi.Messages;

const

  WM_TASK_INSTANCE_CHANGED = WM_USER + 1000;
  WM_TASK_SEND_DATA        = WM_USER + 1001;
  WM_TASK_SEND_PROGRESS    = WM_USER + 1002;

  BOM_UTF8 = #$EF#$BB#$BF;

  CR     = #13;
  LF     = #10;
  CRLF   = #13#10;
  CRLFx2 = CRLF + CRLF;

  IC_MAX_RUNNING_THREAD_COUNT = 10;
  IC_MAX_DATA_PULLING_LENGTH  = 4000;
  IC_MIN_POSTING_INTERVAL     = 30;

  SC_TASK_STATE_CREATED_CAPTION    = 'Создана';
  SC_TASK_STATE_WAITING_CAPTION    = 'В ожидании';
  SC_TASK_STATE_PROCESSING_CAPTION = 'Выполняется';
  SC_TASK_STATE_FINISHED_CAPTION   = 'Завершена';
  SC_TASK_STATE_CANCELED_CAPTION   = 'Прервана';
  SC_TASK_STATE_ERROR_CAPTION      = 'Ошибка';

  SC_TASK_STATE_CREATED_REPORT    = 'Задача создана.';
  SC_TASK_STATE_WAITING_REPORT    = 'Задача находится в ожидании запуска.';
  SC_TASK_STATE_PROCESSING_REPORT = 'Выполнение задачи запущено.';
  SC_TASK_STATE_FINISHED_REPORT   = 'Выполнение задачи завершено.';
  SC_TASK_STATE_CANCELED_REPORT   = 'Выполнение задачи прервано.';
  SC_TASK_STATE_ERROR_REPORT      = 'При выполнении задачи возникла ошибка.';

  SC_TASK_COMPLETED_REPORT = 'Время выполнения: %s.';
  SC_TASK_SUMMARY          = 'Всего задач %d, запущено %d, успешно завершено %d.';

  SC_TASK_NAME_UNIQUE_ERROR = 'Задача с именем ''%s'' уже зарегистрирована. Укажите уникальное имя задачи.';
  SC_TASK_EXECUTE_ERROR     = 'При выполнении задачи возникло исключение %s: %s.';

implementation

end.
