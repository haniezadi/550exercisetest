DO $$ 
DECLARE
  v_base_id uuid;
BEGIN
-- Base food: شیر کم‌چرب (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('شیر کم‌چرب', 'compound', 'snack', 'simple', 'snack:2:شیر-کمچرب', 'شیر کم‌چرب با حدود ۴۶ کالری / ۳٫۴ گرم پروتئین در ۱۰۰ میلی‌لیتر؛ بدون شکر، عسل و پودرهای شیرین. درصد چربی و اطلاعات روی بستهٔ شیر، مبنای دقیق‌تر محاسبه هستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 110 cal, 8g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیر کم‌چرب — 110 کالری', 'compound', 'snack', 'simple',
    v_base_id, '110 کالری', 110, 8,
    'snack:2:شیر-کمچرب:110', '[{"name":"شیر کم‌چرب","amount":"۲۳۰ میلی‌لیتر","household":"۱ لیوان استاندارد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 160 cal, 12g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیر کم‌چرب — 160 کالری', 'compound', 'snack', 'simple',
    v_base_id, '160 کالری', 160, 12,
    'snack:2:شیر-کمچرب:160', '[{"name":"شیر کم‌چرب","amount":"۳۴۵ میلی‌لیتر","household":"۱½ لیوان استاندارد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 210 cal, 16g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیر کم‌چرب — 210 کالری', 'compound', 'snack', 'simple',
    v_base_id, '210 کالری', 210, 16,
    'snack:2:شیر-کمچرب:210', '[{"name":"شیر کم‌چرب","amount":"۴۶۰ میلی‌لیتر","household":"۲ لیوان استاندارد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ماست ساده کم‌چرب (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ماست ساده کم‌چرب', 'compound', 'snack', 'simple', 'snack:3:ماست-ساده-کمچرب', 'ماست معمولیِ بدون شکر افزوده با حدود ۶۰ کالری / ۴ گرم پروتئین در ۱۰۰ گرم. ماست چکیده، پرچرب یا میوه‌ای، جایگزین مستقیم این محاسبه نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 7g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست ساده کم‌چرب — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 7,
    'snack:3:ماست-ساده-کمچرب:100', '[{"name":"ماست کم‌چرب","amount":"۱۶۵ گرم","household":"۱۱ قاشق غذاخوری سرصاف"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 10g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست ساده کم‌چرب — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 10,
    'snack:3:ماست-ساده-کمچرب:150', '[{"name":"ماست کم‌چرب","amount":"۲۵۰ گرم","household":"حدود ۱ کاسهٔ کوچک پُر"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 13g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست ساده کم‌چرب — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 13,
    'snack:3:ماست-ساده-کمچرب:200', '[{"name":"ماست کم‌چرب","amount":"۳۳۰ گرم","household":"۲۲ قاشق غذاخوری سرصاف"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: تخم‌مرغ آب‌پز (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('تخم‌مرغ آب‌پز', 'compound', 'snack', 'simple', 'snack:4:تخممرغ-آبپز', 'هر تخم‌مرغ حدود ۵۰ گرم قسمت خوراکی، ۷۰ کالری و ۶ گرم پروتئین؛ بدون روغن. وزن‌ها بدون پوسته هستند. اندازهٔ تخم‌مرغ می‌تواند کالری و پروتئین را کمی تغییر دهد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 70 cal, 6g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'تخم‌مرغ آب‌پز — 70 کالری', 'compound', 'snack', 'simple',
    v_base_id, '70 کالری', 70, 6,
    'snack:4:تخممرغ-آبپز:70', '[{"name":"تخم‌مرغ آب‌پز","amount":"۵۰ گرم","household":"۱ عدد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 140 cal, 13g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'تخم‌مرغ آب‌پز — 140 کالری', 'compound', 'snack', 'simple',
    v_base_id, '140 کالری', 140, 13,
    'snack:4:تخممرغ-آبپز:140', '[{"name":"تخم‌مرغ آب‌پز","amount":"۱۰۰ گرم","household":"۲ عدد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 220 cal, 19g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'تخم‌مرغ آب‌پز — 220 کالری', 'compound', 'snack', 'simple',
    v_base_id, '220 کالری', 220, 19,
    'snack:4:تخممرغ-آبپز:220', '[{"name":"تخم‌مرغ آب‌پز","amount":"۱۵۰ گرم","household":"۳ عدد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: خرما (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('خرما', 'compound', 'snack', 'simple', 'snack:5:خرما', 'خرمای کوچک تا متوسط، بدون هسته؛ هر عدد حدود ۸ گرم. برآورد انرژی حدود ۲۸۰ کالری در ۱۰۰ گرم است. خرمای درشت، مانند مجول، با همین تعداد کالری بسیار بیشتری دارد؛ وزن بدون هسته ملاک است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 90 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خرما — 90 کالری', 'compound', 'snack', 'simple',
    v_base_id, '90 کالری', 90, 1,
    'snack:5:خرما:90', '[{"name":"خرمای بدون هسته","amount":"۳۲ گرم","household":"۴ عدد کوچک تا متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 130 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خرما — 130 کالری', 'compound', 'snack', 'simple',
    v_base_id, '130 کالری', 130, 1,
    'snack:5:خرما:130', '[{"name":"خرمای بدون هسته","amount":"۴۸ گرم","household":"۶ عدد کوچک تا متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 180 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خرما — 180 کالری', 'compound', 'snack', 'simple',
    v_base_id, '180 کالری', 180, 2,
    'snack:5:خرما:180', '[{"name":"خرمای بدون هسته","amount":"۶۴ گرم","household":"۸ عدد کوچک تا متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: مغز گردو (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('مغز گردو', 'compound', 'snack', 'simple', 'snack:6:مغز-گردو', 'هر مغز کامل گردوی متوسط حدود ۴ گرم است؛ یعنی دو نیمهٔ مغز گردو. وزن‌ها مربوط به مغز بدون پوست سخت هستند. اندازهٔ گردوها متفاوت است؛ تعداد فقط معادل تقریبی وزن است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'مغز گردو — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 2,
    'snack:6:مغز-گردو:100', '[{"name":"مغز گردو","amount":"۱۶ گرم","household":"۴ مغز کامل گردو یا ۸ نیمه"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 160 cal, 4g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'مغز گردو — 160 کالری', 'compound', 'snack', 'simple',
    v_base_id, '160 کالری', 160, 4,
    'snack:6:مغز-گردو:160', '[{"name":"مغز گردو","amount":"۲۴ گرم","household":"۶ مغز کامل گردو یا ۱۲ نیمه"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 210 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'مغز گردو — 210 کالری', 'compound', 'snack', 'simple',
    v_base_id, '210 کالری', 210, 5,
    'snack:6:مغز-گردو:210', '[{"name":"مغز گردو","amount":"۳۲ گرم","household":"۸ مغز کامل گردو یا ۱۶ نیمه"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: بادام (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('بادام', 'compound', 'snack', 'simple', 'snack:7:بادام', 'بادام خام یا بودادهٔ بدون روغن، بدون روکش؛ هر مغز کامل متوسط حدود ۱٫۲ گرم. بادام روغنی، شکری یا شکلاتی، با این برآورد یکسان نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 4g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بادام — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 4,
    'snack:7:بادام:100', '[{"name":"بادام","amount":"۱۷ گرم","household":"۱۴ مغز کامل بادام"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بادام — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 5,
    'snack:7:بادام:150', '[{"name":"بادام","amount":"۲۶ گرم","household":"۲۲ مغز کامل بادام"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 7g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بادام — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 7,
    'snack:7:بادام:200', '[{"name":"بادام","amount":"۳۵ گرم","household":"۲۹ مغز کامل بادام"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: خیار (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('خیار', 'compound', 'snack', 'simple', 'snack:8:خیار', 'خیار تازه، بدون سس و روغن؛ حدود ۱۵ کالری در ۱۰۰ گرم. برای خیار، سهم‌های معمول نوشته شده‌اند و مقدار آن برای رسیدن اجباری به ۲۰۰ کالری افزایش داده نشده است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 20 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خیار — 20 کالری', 'compound', 'snack', 'simple',
    v_base_id, '20 کالری', 20, 1,
    'snack:8:خیار:20', '[{"name":"خیار","amount":"۱۵۰ گرم","household":"۲ عدد کوچک یا حدود ۱ لیوان خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 30 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خیار — 30 کالری', 'compound', 'snack', 'simple',
    v_base_id, '30 کالری', 30, 1,
    'snack:8:خیار:30', '[{"name":"خیار","amount":"۲۰۰ گرم","household":"۲ عدد متوسط یا حدود ۱½ لیوان خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 40 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خیار — 40 کالری', 'compound', 'snack', 'simple',
    v_base_id, '40 کالری', 40, 2,
    'snack:8:خیار:40', '[{"name":"خیار","amount":"۲۵۰ گرم","household":"۳ عدد کوچک تا متوسط یا حدود ۲ لیوان خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, nullg protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خیار — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, NULL,
    'snack:8:خیار:200', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: هویج (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('هویج', 'compound', 'snack', 'simple', 'snack:9:هویج', 'هویج خام، بدون سس و روغن؛ حدود ۴۱ کالری در ۱۰۰ گرم.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 40 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'هویج — 40 کالری', 'compound', 'snack', 'simple',
    v_base_id, '40 کالری', 40, 1,
    'snack:9:هویج:40', '[{"name":"هویج","amount":"۱۰۰ گرم","household":"۱ عدد بزرگ یا ۲ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 60 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'هویج — 60 کالری', 'compound', 'snack', 'simple',
    v_base_id, '60 کالری', 60, 1,
    'snack:9:هویج:60', '[{"name":"هویج","amount":"۱۵۰ گرم","household":"۲ عدد متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 80 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'هویج — 80 کالری', 'compound', 'snack', 'simple',
    v_base_id, '80 کالری', 80, 2,
    'snack:9:هویج:80', '[{"name":"هویج","amount":"۲۰۰ گرم","household":"۲ عدد بزرگ یا ۳ عدد متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, nullg protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'هویج — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, NULL,
    'snack:9:هویج:200', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: پاپ‌کورن بدون روغن (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('پاپ‌کورن بدون روغن', 'compound', 'snack', 'simple', 'snack:10:پاپکورن-بدون-روغن', 'ذرت بوداده با هوای گرم یا در ظرف مناسب، بدون روغن، کره، شکر و کارامل. هر لیوان استاندارد پاپ‌کورنِ بدون فشردن حدود ۸ گرم است. وزن‌ها مربوط به پاپ‌کورن آماده هستند، نه دانهٔ خشک ذرت.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پاپ‌کورن بدون روغن — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 3,
    'snack:10:پاپکورن-بدون-روغن:100', '[{"name":"پاپ‌کورن آماده","amount":"۲۵ گرم","household":"حدود ۳ لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پاپ‌کورن بدون روغن — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 5,
    'snack:10:پاپکورن-بدون-روغن:150', '[{"name":"پاپ‌کورن آماده","amount":"۴۰ گرم","household":"حدود ۵ لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 7g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پاپ‌کورن بدون روغن — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 7,
    'snack:10:پاپکورن-بدون-روغن:200', '[{"name":"پاپ‌کورن آماده","amount":"۵۲ گرم","household":"حدود ۶½ لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: قهوه با شیر (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('قهوه با شیر', 'compound', 'snack', 'simple', 'snack:11:قهوه-با-شیر', 'قهوهٔ ساده همراه شیر کم‌چرب؛ بدون شکر، خامه، سیروپ و پودر کافی‌میکس. حجم شیر پیش از کف‌دادن اندازه‌گیری می‌شود. تعداد شات در هر سه نسخه ثابت است؛ افزودنی‌های شیرین جدا محاسبه می‌شوند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 110 cal, 8g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قهوه با شیر — 110 کالری', 'compound', 'snack', 'simple',
    v_base_id, '110 کالری', 110, 8,
    'snack:11:قهوه-با-شیر:110', '[{"name":"قهوهٔ دم‌شده","amount":"۳۰ میلی‌لیتر","household":"۱ شات"},{"name":"شیر کم‌چرب","amount":"۲۳۰ میلی‌لیتر","household":"۱ لیوان استاندارد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 160 cal, 12g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قهوه با شیر — 160 کالری', 'compound', 'snack', 'simple',
    v_base_id, '160 کالری', 160, 12,
    'snack:11:قهوه-با-شیر:160', '[{"name":"قهوهٔ دم‌شده","amount":"۳۰ میلی‌لیتر","household":"۱ شات"},{"name":"شیر کم‌چرب","amount":"۳۴۵ میلی‌لیتر","household":"۱½ لیوان استاندارد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 210 cal, 16g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قهوه با شیر — 210 کالری', 'compound', 'snack', 'simple',
    v_base_id, '210 کالری', 210, 16,
    'snack:11:قهوه-با-شیر:210', '[{"name":"قهوهٔ دم‌شده","amount":"۳۰ میلی‌لیتر","household":"۱ شات"},{"name":"شیر کم‌چرب","amount":"۴۶۰ میلی‌لیتر","household":"۲ لیوان استاندارد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: چیپس (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('چیپس', 'compound', 'snack', 'simple', 'snack:1:چیپس', 'چیپس سیب‌زمینی معمولی با حدود ۵۳۰ کالری / ۶ گرم پروتئین در ۱۰۰ گرم. ضخامت و اندازهٔ برش‌ها متفاوت است؛ وزن و برچسب بسته ملاک هستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'چیپس — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 1,
    'snack:1:چیپس:100', '[{"name":"چیپس","amount":"۱۹ گرم","household":"حدود ۱ مشت کوچک، بدون فشردن"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'چیپس — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 2,
    'snack:1:چیپس:150', '[{"name":"چیپس","amount":"۲۸ گرم","household":"حدود ۱½ مشت کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'چیپس — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 2,
    'snack:1:چیپس:200', '[{"name":"چیپس","amount":"۳۸ گرم","household":"حدود ۲ مشت کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: پفک (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('پفک', 'compound', 'snack', 'simple', 'snack:2:پفک', 'اسنک پنیری معمولی با حدود ۵۲۰ کالری / ۶ گرم پروتئین در ۱۰۰ گرم. معادل لیوان با شکل و تراکم پفک تغییر می‌کند؛ یک‌بار سهم محصول خودت را وزن کن.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پفک — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 1,
    'snack:2:پفک:100', '[{"name":"پفک","amount":"۱۹ گرم","household":"حدود ۱ لیوان پُر، بدون فشردن"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پفک — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 2,
    'snack:2:پفک:150', '[{"name":"پفک","amount":"۲۹ گرم","household":"حدود ۱½ لیوان پُر"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پفک — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 2,
    'snack:2:پفک:200', '[{"name":"پفک","amount":"۳۸ گرم","household":"حدود ۲ لیوان پُر"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: بیسکویت ساده (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('بیسکویت ساده', 'compound', 'snack', 'simple', 'snack:3:بیسکویت-ساده', 'بیسکویت ساده با حدود ۴۳۰ کالری / ۷ گرم پروتئین در ۱۰۰ گرم؛ هر عدد فرضی حدود ۶ گرم. اگر بیسکویت‌ها بزرگ‌تر یا کوچک‌ترند، تعداد را با وزن هر عدد روی بسته تنظیم کن.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بیسکویت ساده — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 2,
    'snack:3:بیسکویت-ساده:100', '[{"name":"بیسکویت ساده","amount":"۲۳ گرم","household":"حدود ۴ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بیسکویت ساده — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 2,
    'snack:3:بیسکویت-ساده:150', '[{"name":"بیسکویت ساده","amount":"۳۵ گرم","household":"حدود ۶ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بیسکویت ساده — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 3,
    'snack:3:بیسکویت-ساده:200', '[{"name":"بیسکویت ساده","amount":"۴۷ گرم","household":"حدود ۸ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: بیسکویت کرم‌دار (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('بیسکویت کرم‌دار', 'compound', 'snack', 'simple', 'snack:4:بیسکویت-کرمدار', 'حدود ۴۹۰ کالری / ۵ گرم پروتئین در ۱۰۰ گرم؛ هر عدد فرضی حدود ۱۰ گرم. کرم داخل وزن بیسکویت حساب شده است. تعداد فقط برای بیسکویت حدود ۱۰ گرمی صدق می‌کند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بیسکویت کرم‌دار — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 1,
    'snack:4:بیسکویت-کرمدار:100', '[{"name":"بیسکویت کرم‌دار","amount":"۲۰ گرم","household":"۲ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بیسکویت کرم‌دار — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 2,
    'snack:4:بیسکویت-کرمدار:150', '[{"name":"بیسکویت کرم‌دار","amount":"۳۰ گرم","household":"۳ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بیسکویت کرم‌دار — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 2,
    'snack:4:بیسکویت-کرمدار:200', '[{"name":"بیسکویت کرم‌دار","amount":"۴۱ گرم","household":"۴ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ویفر (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ویفر', 'compound', 'snack', 'simple', 'snack:5:ویفر', 'ویفر معمولی با حدود ۵۲۰ کالری / ۵ گرم پروتئین در ۱۰۰ گرم؛ هر قطعهٔ فرضی حدود ۱۰ گرم. ویفر با روکش شکلاتی یا اندازهٔ متفاوت باید بر اساس برچسب خودش محاسبه شود.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ویفر — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 1,
    'snack:5:ویفر:100', '[{"name":"ویفر","amount":"۱۹ گرم","household":"حدود ۲ قطعهٔ کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ویفر — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 1,
    'snack:5:ویفر:150', '[{"name":"ویفر","amount":"۲۹ گرم","household":"حدود ۳ قطعهٔ کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ویفر — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 2,
    'snack:5:ویفر:200', '[{"name":"ویفر","amount":"۳۸ گرم","household":"حدود ۴ قطعهٔ کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: کیک بسته‌بندی‌شده (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('کیک بسته‌بندی‌شده', 'compound', 'snack', 'simple', 'snack:6:کیک-بستهبندیشده', 'کیک سادهٔ بسته‌بندی‌شده با حدود ۴۰۰ کالری / ۵ گرم پروتئین در ۱۰۰ گرم؛ بستهٔ فرضی ۵۰ گرمی. کیک مغزدار، شکلاتی یا دارای روکش ممکن است کالری بیشتری داشته باشد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کیک بسته‌بندی‌شده — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 1,
    'snack:6:کیک-بستهبندیشده:100', '[{"name":"کیک","amount":"۲۵ گرم","household":"نصف یک کیک ۵۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کیک بسته‌بندی‌شده — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 2,
    'snack:6:کیک-بستهبندیشده:150', '[{"name":"کیک","amount":"۳۸ گرم","household":"حدود ¾ یک کیک ۵۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کیک بسته‌بندی‌شده — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 3,
    'snack:6:کیک-بستهبندیشده:200', '[{"name":"کیک","amount":"۵۰ گرم","household":"۱ عدد کیک ۵۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: کلوچه (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('کلوچه', 'compound', 'snack', 'simple', 'snack:7:کلوچه', 'کلوچهٔ معمولی با حدود ۴۳۰ کالری / ۶ گرم پروتئین در ۱۰۰ گرم؛ کلوچهٔ فرضی ۷۰ گرمی. مغز کلوچه داخل وزن سهم حساب شده است؛ اندازهٔ کلوچه و ترکیب مغز آن ثابت نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کلوچه — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 1,
    'snack:7:کلوچه:100', '[{"name":"کلوچه","amount":"۲۳ گرم","household":"حدود ⅓ یک کلوچهٔ ۷۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کلوچه — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 2,
    'snack:7:کلوچه:150', '[{"name":"کلوچه","amount":"۳۵ گرم","household":"نصف یک کلوچهٔ ۷۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کلوچه — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 3,
    'snack:7:کلوچه:200', '[{"name":"کلوچه","amount":"۴۷ گرم","household":"حدود ⅔ یک کلوچهٔ ۷۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: شکلات (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('شکلات', 'compound', 'snack', 'simple', 'snack:8:شکلات', 'شکلات شیری ساده با حدود ۵۴۰ کالری / ۷ گرم پروتئین در ۱۰۰ گرم؛ هر مربع فرضی حدود ۵ گرم. شکلات تلخ، مغزدار یا کاراملی برچسب متفاوتی دارد؛ اندازهٔ مربع‌ها نیز یکسان نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شکلات — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 1,
    'snack:8:شکلات:100', '[{"name":"شکلات","amount":"۱۹ گرم","household":"حدود ۴ مربع کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شکلات — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 2,
    'snack:8:شکلات:150', '[{"name":"شکلات","amount":"۲۸ گرم","household":"حدود ۶ مربع کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شکلات — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 3,
    'snack:8:شکلات:200', '[{"name":"شکلات","amount":"۳۷ گرم","household":"حدود ۷–۸ مربع کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: بستنی (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('بستنی', 'compound', 'snack', 'simple', 'snack:9:بستنی', 'بستنی شیری ساده با حدود ۲۰۰ کالری / ۴ گرم پروتئین در ۱۰۰ گرم؛ هر اسکوپ کوچک فرضی حدود ۵۰ گرم. نان بستنی، روکش شکلات، سس و مغزها در محاسبه نیستند. برای بستنی بسته‌بندی‌شده، کالری کل یا سهم مصرفی روی برچسب ملاک است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بستنی — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 2,
    'snack:9:بستنی:100', '[{"name":"بستنی","amount":"۵۰ گرم","household":"۱ اسکوپ کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بستنی — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 3,
    'snack:9:بستنی:150', '[{"name":"بستنی","amount":"۷۵ گرم","household":"۱½ اسکوپ کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 4g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'بستنی — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 4,
    'snack:9:بستنی:200', '[{"name":"بستنی","amount":"۱۰۰ گرم","household":"۲ اسکوپ کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: پاپ‌کورن بسته‌بندی‌شده (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('پاپ‌کورن بسته‌بندی‌شده', 'compound', 'snack', 'simple', 'snack:10:پاپکورن-بستهبندیشده', 'پاپ‌کورن نمکیِ روغنی با حدود ۴۸۰ کالری / ۸ گرم پروتئین در ۱۰۰ گرم. این برآورد برای پاپ‌کورن کاراملی یا شکلاتی نیست. مقدار روغن و تراکم محصول، کالری و معادل لیوان را تغییر می‌دهد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پاپ‌کورن بسته‌بندی‌شده — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 2,
    'snack:10:پاپکورن-بستهبندیشده:100', '[{"name":"پاپ‌کورن","amount":"۲۱ گرم","household":"حدود ۲½ لیوان، بدون فشردن"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پاپ‌کورن بسته‌بندی‌شده — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 2,
    'snack:10:پاپکورن-بستهبندیشده:150', '[{"name":"پاپ‌کورن","amount":"۳۱ گرم","household":"حدود ۴ لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پاپ‌کورن بسته‌بندی‌شده — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 3,
    'snack:10:پاپکورن-بستهبندیشده:200', '[{"name":"پاپ‌کورن","amount":"۴۲ گرم","household":"حدود ۵ لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  
END $$;;
