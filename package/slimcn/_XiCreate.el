(defun xi-replace-template-name (name)
  "�滻XI�ű�ģ���е�name������+Name+ --> Name"
  (interactive "sName : ")
  (save-excursion  
    (goto-char (point-min))
    (replace-string "+Name+" name)))
(defun xi-replace-template-nameCN (nameCN)
  "�滻XI�ű�ģ���е�����name������+NameCN+ --> nameCN"
  (interactive "sNameCN : ")
  (save-excursion  
    (goto-char (point-min))
    (replace-string "+NameCN+" name)))
(defun xi-replace-template-table (table)
  "�滻XI�ű�ģ���е�table������+Table+ --> table"
  (interactive "sTable Name : ")
  (save-excursion  
    (goto-char (point-min))
    (replace-string "+Table+" table)))


(defun xi-create-sheet-from-table-line (arg)
  "���ݱ�ṹ�ֶ��У���tab��ո�ָ�����������б��Զ�Ӧ�ű�����ص����ԣ��Դ����ɽű�.
       ���룺�������б�ͬ˳������ݼ���ͬ�м�¼���Լ���tab�����
  xi-property-list(xi-property(�������� ������� ��������))"
  (interactive "s���m������d���ࣻt��������")
  (setq xi-area-property-list-mast (list "����" "����" "����" "����Ϊ��" "������Դ" "�ύȥ��" "���뷽ʽ" "��ťͼ��" "Ĭ��ֵ" "��������" "��������" "��" "��" "��" "���" "�߶�" "�л�˳��" "�����л�" "��ʾ��ʽ"))  ; ���Դ���������¼����
  (setq xi-area-property-list-detail (list "����" "����" "����" "����Ϊ��" "������Դ" "�ύȥ��" "���뷽ʽ" "��ťͼ��" "Ĭ��ֵ" "��������" "��������" "���" "�л�˳��" "�����л�" "��ʾ��ʽ"))  ; ���Դ��������¼����
  (setq xi-area-property-list-tree (list "����" "����" "������Դ" "Ȩ�����"))  ; ���Դ�����������
  (setq xi-area-property-list-unused (list "������Դ" "�����ַ�" "�ַ���ʽ" "ת¼��Դ" "���ȥ��" "��������" "�ύԼ��" "�޸�Լ��" "���Լ��" "Ȩ�����" "��ʾ"))
  (setq xi-area-property-list-mast-std (list "����" "����" "����" "������Դ" "�����ַ�" "�ַ���ʽ" "����Ϊ��" "������Դ" "ת¼��Դ" "�ύȥ��" "���ȥ��" "���뷽ʽ" "��������" "��ťͼ��" "�ύԼ��" "�޸�Լ��" "���Լ��" "Ĭ��ֵ" "��������" "��������" "Ȩ�����" "��" "��" "��" "���" "�߶�" "�л�˳��" "�����л�" "��ʾ" "��ʾ��ʽ"))
  (setq xi-area-property-list-detail-std (list "����" "����" "����" "������Դ" "�����ַ�" "�ַ���ʽ" "����Ϊ��" "������Դ" "ת¼��Դ" "�ύȥ��" "���ȥ��" "���뷽ʽ" "��������" "��ťͼ��" "�ύԼ��" "�޸�Լ��" "���Լ��" "Ĭ��ֵ" "��������" "��������" "Ȩ�����" "���" "�����л�" "��ʾ" "��ʾ��ʽ"))

  ;; ���������б� 
  (if (equal (upcase arg) "D")  
	  ;(setq xi-area-property-list (append xi-area-property-list-detail xi-area-property-list-unused))
	  (setq xi-area-property-list xi-area-property-list-detail-std)
	(if (equal (upcase arg) "T")
		(setq xi-area-property-list xi-area-property-list-tree)
	  ;;(setq xi-area-property-list (append xi-area-property-list-mast xi-area-property-list-unused))
	  (setq xi-area-property-list xi-area-property-list-mast-std)
	  ))

  (setq xi-area-string "")  ; ��ʼ���򴮣��Է�ֹnil����
  (setq line-number-old 0)  ; ǰ�δ������λ�ã��Կ���ѭ��
  (save-excursion
	(goto-char (point-max))
	(setq line-number-max (line-number-at-pos)))  ; ��������������ֹ next-line �������ܵĳ���
  ;(goto-char 0)  ;�ƶ�����ʼ��׼������
  (save-excursion
	(setq line-number-now (line-number-at-pos))
	(while (> line-number-now line-number-old)
	  (if (= (line-beginning-position) (line-end-position))
		  ()
		(progn 
		  (setq line-string (buffer-substring (line-beginning-position) (line-end-position))) ;��������ݴ�
		  (setq line-string-list (split-string line-string "\t" nil)) ;�ָ������ݴ�Ϊ�б�˳��ͬ�����б�
		  (setq xi-area-string (concat xi-area-string (xi-create-area-from-value-list xi-area-property-list line-string-list arg)))))
	  (setq line-number-old line-number-now)
	  (if (< (line-number-at-pos) line-number-max)
		  (next-line))
	  (setq line-number-now (line-number-at-pos)))) ; ���ݽű���ʽ�������б���������ű�
(insert "\n")
  (insert xi-area-string))

(defun kill-ring-save-current-line ()
  "copy the current non-empty line to the kill-ring"
  (interactive)
  (unless (equal (line-beginning-position) (line-end-position))
    (kill-ring-save (line-beginning-position) (line-end-position))))

(defun xi-create-area-from-value-list (property-list value-list object-type)
  "���ݴ������������ֵ�б��������б��Ӧ�����x+i��ʽ������ű�"
  (if (equal "����" (car property-list))
	  (progn
		(setq prefix-string1 (make-string 8 ? ))
		(setq prefix-string2 (make-string 12 ? ))))
  (setq area-string (concat prefix-string1 (car property-list) " : " (car value-list) "\n"))  ;���õ�һ�����ԣ�ͬʱΪ��������ֵ���Ա����nil�Ĳ�������
  (setq property-list-temp (cdr property-list))
  (setq value-list-temp (cdr value-list))
  (while property-list-temp
	(if (equal "��������" (car property-list-temp))
		(setq area-string (concat area-string (concat prefix-string2 (car property-list-temp) " = @" (car value-list-temp) "\n")))
	  (if (equal "��������" (car property-list-temp))
		  (setq area-string (concat area-string (concat prefix-string2 (car property-list-temp) " = @" (car value-list-temp) "\n")))
		(if (equal "�����л�" (car property-list-temp))
			(setq area-string (concat area-string (concat prefix-string2 (car property-list-temp) " = @" (car value-list-temp) "\n")))
		  (if (equal "������Դ" (car property-list-temp))
			  (if (equal "D" (upcase object-type))
				  (setq area-string (concat area-string (concat prefix-string2 (car property-list-temp) " = [A?" (car value-list-temp) "]\n")))
				(if (equal "DI" (upcase object-type))
					(setq area-string (concat area-string (concat prefix-string2 (car property-list-temp) " = [G?" (car value-list-temp) "]\n")))
				  (setq area-string (concat area-string (concat prefix-string2 (car property-list-temp) " = [B?" (car value-list-temp) "]\n")))))				
			(setq area-string (concat area-string (concat prefix-string2 (car property-list-temp) " = " (car value-list-temp) "\n")))))))
		  
		  
	(setq property-list-temp (cdr property-list-temp))
	(setq value-list-temp (cdr value-list-temp)))
  (setq area-string (concat area-string (concat prefix-string1 "��β\n")))
  area-string)
