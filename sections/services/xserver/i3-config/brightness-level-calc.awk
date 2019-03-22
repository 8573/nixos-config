# Global variables expected:
# - mapped_delta: should be 1 or -1
# - mapped_max
# - raw_max
# - raw_old

BEGIN {
  raw_min = 0;
  mapped_min = 1;

  # <https://stackoverflow.com/a/19472811>
  b = log(raw_max) / (mapped_max - mapped_min);
  a = raw_max / exp(b * mapped_max);

  # This would simulate the brightness being decremented to its minimum, then
  # incremented to its maximum.
  #print(raw_max);
  #for (rv = raw_max; rv > raw_min; rv = print_new_raw(rv, -1)) {}
  #for (; rv < raw_max; rv = print_new_raw(rv, 1)) {}

  print_new_raw(raw_old, mapped_delta);
}

function print_new_raw(r_old, m_delta) {
  new = int(new_raw(r_old, m_delta));
  print(new);
  return new
}

function new_raw(r_old, m_delta) {
  # Threshold to adjust brightness exponentially
  exp_threshold = raw_max / (mapped_max * exp(1));

  low_threshold = raw_max / (mapped_max * exp(exp(1)));

  if (r_old > exp_threshold) {
    m_new = int(0.5 + raw_to_mapped(r_old) + m_delta);
    m_new = m_new > mapped_min ? m_new : mapped_min;
    r_new = mapped_to_raw(m_new);
  } else if (r_old < 1) {
    r_new = raw_min + (m_delta > 0 ? 1 : 0);
  } else if (abs_diff(r_old, raw_min) < low_threshold) {
    r_new = m_delta > 0 ? exp(1)*low_threshold : raw_min;
  } else {
    r_new = r_old + m_delta * low_threshold;
  }

  r_new = int(0.5 * m_delta + r_new);
  r_new = r_new > raw_min ? r_new : raw_min;
  r_new = r_new < (raw_max - low_threshold) ? r_new : raw_max;

  return r_new;
}

function mapped_to_raw(m) {
  return a * exp(b * m)
}

function raw_to_mapped(r) {
  return log(r / a) / b
}

function abs_diff(x1, x2) {
  d = x1 - x2;
  return d > 0 ? d : -d
}
