;; Ĭ�Ͻ���outline-mode/auto-fillģʽ
;;(setq default-major-mode 'outline-mode)
;;(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;; �ű�ģ������
(defun xi-Event (EventName)
  "�¼�ģ��"
  (interactive "sEvent Name:")
  (if (equal "*" (substring EventName 0 1))
      (insert "\n**    �¼� : ")
    (insert "\n    �¼� : "))
  (if (equal "*" (substring EventName 0 1))
      (setq EventName (substring EventName 1 nil) FirstActionName "*EventCondition")
    (setq FirstActionName "EventCondition"))
  (insert EventName)
  (insert "\n        ���� =\n        ����֧�� =\n        ״̬��� =\n        ����״̬ =\n        �ȼ� =")
  (xi-Action FirstActionName)
  (save-excursion
    (next-line)
    (insert "\n    ��β")))

(defun xi-Action (ActionName)
  "����ģ��"
  (interactive "sAction Name:")
  (if (equal "*" (substring ActionName 0 1))
      (insert "\n***        ���� : ")
    (insert "\n        ���� : "))
  (if (equal "*" (substring ActionName 0 1))
      (setq ActionName (substring ActionName 1 nil)))
      (insert ActionName)
      (insert "\n            ���� = \n            ���� = ")
      (save-excursion
        (insert "\n        ��β")))

(defun xi-Compute (Name)
  "�м����ģ��"
  (interactive "sName:")
  (if (equal "*" (substring Name 0 1))
      (insert "\n***            �м���� : ")
    (insert "\n            �м����: "))
  (if (equal "*" (substring Name 0 1))
      (setq Name (substring Name 1 nil)))
      (insert Name)
      (save-excursion
                (insert "\n                ������Դ = ")
                (insert "\n            ��β")))

(defun xi-AreaS (VarName)
  "����¼����ģ��"
  (interactive "sSimple Area Name:")
  (if (equal "*" (substring VarName 0 1))
      (insert "\n***        ���� : ")
    (insert "\n        ���� : "))
  (if (equal "*" (substring VarName 0 1))
      (setq VarName (substring VarName 1 nil)))
      (insert VarName)
      (save-excursion
        (insert "\n            ���� = \n            ���� = s(30)\n            ������Դ = \n            �����ַ� = \n            �ַ���ʽ = \n            ����Ϊ�� = ��\n            ������Դ = [B?]\n            ת¼��Դ = \n            �ύȥ�� = \n            ���뷽ʽ = ֱ��\n            �������� = \n            ��ťͼ�� = \n            �ύԼ�� = \n            �޸�Լ�� = \n            ���Լ�� = \n            Ĭ��ֵ = \n            �������� = @1\n            �������� = @0\n            Ȩ����� = \n            �� = g\n            �� = 1\n            �� = 1\n            ��� = 3\n            �߶� = 1\n            �л�˳�� = \n            �����л� = @1\n            ��ʾ = \n            ��ʾ��ʽ = \n        ��β")
       ))

(defun xi-AreaD (VarName)
  "���¼����ģ��"
  (interactive "sDetail Area Name:")
  (if (equal "*" (substring VarName 0 1))
      (insert "\n***        ���� : ")
    (insert "\n        ���� : "))
  (if (equal "*" (substring VarName 0 1))
      (setq VarName (substring VarName 1 nil)))
      (insert VarName)
      (save-excursion
        (insert "\n            ���� = \n            ���� = s(30)\n            ������Դ = \n            �����ַ� = \n            �ַ���ʽ = \n            ����Ϊ�� = ��\n            ������Դ = [A?]\n            ת¼��Դ = \n            �ύȥ�� = \n            ���뷽ʽ = ֱ��\n            �������� = \n            ��ťͼ�� = \n            �ύԼ�� = \n            �޸�Լ�� = \n            ���Լ�� = \n            Ĭ��ֵ = \n            �������� = @1\n            �������� = @0\n            ��� = 60\n            �߶� = 1\n            �����л� = @1\n            ��ʾ = \n            ��ʾ��ʽ = \n        ��β")
       ))

;;; ��ʼ����������

(defun xi-format-to-outline ()
  "��ʽ���ű�Ϊoutline��ʽ"
  (interactive)
  (let ((inhibit-field-text-motion-old inhibit-field-text-motion)
        (xi-script-regexp0 " *\\(�� :\\|���� :\\|������ :\\|Ƥ���б� :\\)+")
        ;(xi-outline-regexp0 "\* *[�� :\|���� :]+")
        (xi-script-regexp1 " *\\(����¼���� :\\|���¼���� :\\|��״���� :\\|״̬ :\\|����ȥ�� :\\|�¼� :\\|��ť�� :\\|��ť :\\|�Ҽ��˵� :\\|״̬�� :\\|ͼƬ :\\|���� :\\|��ѡ�� :\\|��ѡ�� :\\|��֯������ :\\|���ױ� :\\|�˵��� :\\|״̬�� :\\|Ƥ�� :\\)+")
        ;(xi-outline-regexp1 "\* *[����¼���� :\|���¼���� :\|������ :\|�¼� :]+")
        (xi-script-regexp2 " *\\(���� :\\|������Ŀ :\\|�� :\\|���� :\\)+")
        (xi-script-regexp3 " *\\(������Ŀ :\\|�м���� :\\)+"))
    (save-excursion
      (setq inhibit-field-text-motion nil)
      (goto-char (point-min))
      (while (equal (eobp) nil)
          (if (looking-at xi-script-regexp0)
              (insert "*")
            (if (looking-at xi-script-regexp1)
                (insert "**")
              (if (looking-at xi-script-regexp2)
                  (insert "***")
                (if (looking-at xi-script-regexp3)
                    (insert "****")))))
          (beginning-of-line 2))
      (setq inhibit-field-text-motion inhibit-field-text-motion-old))))

(defun xi-format-to-script ()
  "��ʽ��outline�ͽű�Ϊ�淶�ű�"
  (interactive)
  (let ((inhibit-field-text-motion-old inhibit-field-text-motion)
        (xi-outline-regexp0 "*+ *\\(�� :\\|���� :\\|������ :\\|Ƥ���б� :\\)+")
        ;(xi-outline-regexp0 "\* *[�� :\|���� :]+")
        (xi-outline-regexp1 "*+ *\\(����¼���� :\\|���¼���� :\\|��״���� :\\|״̬ :\\|����ȥ�� :\\|�¼� :\\|��ť�� :\\|��ť :\\|�Ҽ��˵� :\\|״̬�� :\\|ͼƬ :\\|���� :\\|��ѡ�� :\\|��ѡ�� :\\|��֯������ :\\|���ױ� :\\|�˵��� :\\|״̬�� :\\|Ƥ�� :\\)+")
        ;(xi-outline-regexp1 "\* *[����¼���� :\|���¼���� :\|������ :\|�¼� :]+")
        (xi-outline-regexp2 "*+ *\\(���� :\\|������Ŀ :\\|�� :\\|���� :\\)+")
        (xi-outline-regexp3 "*+ *\\(������Ŀ :\\|�м���� :\\)+"))
    (save-excursion
      (setq inhibit-field-text-motion nil)
      (goto-char (point-min))
      (while (equal (eobp) nil)
          (if (looking-at xi-outline-regexp0)
              (delete-char 1)
            (if (looking-at xi-outline-regexp1)
                (delete-char 2)
              (if (looking-at xi-outline-regexp2)
                  (delete-char 3)
                (if (looking-at xi-outline-regexp3)
                    (delete-char 4)))))
          (beginning-of-line 2))
      (setq inhibit-field-text-motion inhibit-field-text-motion-old))))


(defun xi-formatSP-to-run ()
  "��ʽ��BizMgr�еĴ洢���̸������Ϊ��ִ�еĹ淶sql���"
  (interactive)
  (save-excursion
        (save-excursion
          ;(move-beginning-of-line)
          (replace-string "ִ�д洢�������: " "EXEC ")
          (replace-string "[" " ")
          (replace-regexp "@[a-zA-Z0-9_]*:[isdhf](" " ")
          ;(replace-regexp ")," " , ")
          (replace-regexp ")]." "\n"))
        (replace-regexp ")," " , ")))


(defun xi-noteS (comment)
  "���ýű���ʼ˵��ע�ͣ��������Ϊע�����ݡ�"
  (interactive "sFile Description : ")
  ;(setq date-current (decode-time))
  (save-excursion
    (insert "//-----------------------------------------------\n")
    (insert "// ������   : SLimcn (")
    (insert (format-time-string "%Y-%m-%d %H:%M:%S"))
    (insert ")\n// �޸ļ�¼ : \n// �ű����� : ")
    (insert comment)
    (insert "\n// �������� : \n//-----------------------------------------------\n")
    (newline)))

(defun xi-note (comment)
  "���ýű�ͷע�ͣ��������Ϊע�����ݡ�"
  (interactive "sNote Comment:")
  ;(setq date-current (decode-time))
  (save-excursion
    (insert )
    (insert "//     �޸���   : SLimcn (")
    (insert (format-time-string "%Y-%m-%d %H:%M:%S"))
    (insert ")\n//     �޸����� : ")
    (insert comment)
        (newline)))
(defun xi-ignore (comment)
  "������ע�ͣ��������Ϊע�����ݡ�"
  (interactive "sNote Comment:")
  ;(setq date-current (decode-time))
  (save-excursion
    (insert )
    (insert "// ")
    (insert (format-time-string "%Y-%m-%d %H:%M:%S"))
    (insert " slimcn ")
    (insert comment)
    (insert " ")))

(defun xi-init ()
  "��ʼ��Xiģʽ����ģʽת��Ϊ outline mode�������Ӳ㼶��ʶ "
  (interactive)
  (save-excursion
    (xi-format-to-outline)
    (outline-mode)
    (hide-body)))

(defun xi-save ()
  "����Xi�ű���ɾ���㼶��ʶ������ű��ļ�"
  (interactive)
  (save-excursion
     (show-all)
     (xi-format-to-script)
     (save-buffer)))

(defvar Xi-mode-map nil

  "Local kymap for Xi mode buffers.")

;���ñ�ģʽ���̲���
;;(if xi-mode-map
;;    nil
;;  (setq xi-mode-map (make-sparse-keymap))
;;  (define-key xi-mode-map "\C-c s" 'xi-save)
;;  (define-key xi-mode-map "\C-c a" 'xi-init))

(defun xi-mode ()
  "xi major mode,just for TiEAM.COM Scripts."
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'xi-mode)
  (setq mode-name "Xi")
  (use-local-map xi-mode-map)
  )

;;; �洢�������

(defun xi-sp-create (name)
  "�洢���̴���ģ��"
  (interactive "sProcedure Name : ")
  (insert "\n\nSET QUOTED_IDENTIFIER ON\nGO\nSET ANSI_NULLS OFF\nGO\n\nif exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[")
  (insert name)
  (insert "]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)\ndrop procedure [dbo].[")
  (insert name)
  (insert "]\nGO\n\n-- ==================================================================\n-- ��    �� : ")
  (save-excursion
    (insert "\n-- ��    �� : \n-- ��    �� : \n-- ��    �� : \n-- ��    �� : SLimcn ")
    (insert (format-time-string "%Y-%m-%d %H:%M:%S"))
    (insert "\n-- ��    �� :\n--        1 : \n--      1.1 : \n--        2 : \n--        3 : \n-- �޸ļ�¼ :\n-- \n-- ������Ϣ : \n-- \n-- ==================================================================\nCREATE   PROCEDURE ")
    (insert name)
    (insert "\n  @p_\n, @p_iDebug int = 0 -- �Ƿ����������Ϣ (0:�����,1:���)\nAS\nbegin\n")
    (insert "\nend\nGO\n\nSET QUOTED_IDENTIFIER OFF\nGO\nSET ANSI_NULLS ON\nGO\n")))

(defun xi-sp-debug ()
  "����洢���̵�����Ϣģ��"
  (interactive)
  (insert "\nif @p_iDebug = 1 \nbegin\n  select ")
  (save-excursion
    (insert "\nend\n")))
