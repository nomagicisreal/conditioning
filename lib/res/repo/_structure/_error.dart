part of structure;

abstract class StructureError extends Error {}
class DataTypeError extends StructureError {}
class QueryNoWhereError extends StructureError {}