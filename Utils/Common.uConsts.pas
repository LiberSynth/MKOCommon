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

  SC_TASK_STATE_CREATED_CAPTION    = '�������';
  SC_TASK_STATE_WAITING_CAPTION    = '� ��������';
  SC_TASK_STATE_PROCESSING_CAPTION = '�����������';
  SC_TASK_STATE_FINISHED_CAPTION   = '���������';
  SC_TASK_STATE_CANCELED_CAPTION   = '��������';
  SC_TASK_STATE_ERROR_CAPTION      = '������';

  SC_TASK_STATE_CREATED_REPORT    = '������ �������.';
  SC_TASK_STATE_WAITING_REPORT    = '������ ��������� � �������� �������.';
  SC_TASK_STATE_PROCESSING_REPORT = '���������� ������ ��������.';
  SC_TASK_STATE_FINISHED_REPORT   = '���������� ������ ���������.';
  SC_TASK_STATE_CANCELED_REPORT   = '���������� ������ ��������.';
  SC_TASK_STATE_ERROR_REPORT      = '��� ���������� ������ �������� ������.';

  SC_TASK_COMPLETED_REPORT = '����� ����������: %s.';
  SC_TASK_SUMMARY          = '����� ����� %d, �������� %d, ������� ��������� %d.';

  SC_TASK_NAME_UNIQUE_ERROR = '������ � ������ ''%s'' ��� ����������������. ������� ���������� ��� ������.';
  SC_TASK_EXECUTE_ERROR     = '��� ���������� ������ �������� ���������� %s: %s.';

implementation

end.
