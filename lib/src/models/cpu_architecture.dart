// ignore_for_file: public_member_api_docs

enum CpuArchitecture { arm64, arm, x86, x86_64, unknown }

extension ParseCpuArchToString on CpuArchitecture {
  String toNameString() {
    switch (this) {
      case CpuArchitecture.arm64:
        return "ARM64";
      case CpuArchitecture.arm:
        return "ARM";
      case CpuArchitecture.x86:
        return "X86";
      case CpuArchitecture.x86_64:
        return "X86_64";
      default:
        return "UNKNOWN";
    }
  }
}

class CpuArchitectureFactory {
  CpuArchitecture fromString(String name) {
    switch (name.toUpperCase()) {
      case "ARM64":
        return CpuArchitecture.arm64;
      case "ARM":
        return CpuArchitecture.arm;
      case "X86":
        return CpuArchitecture.x86;
      case "X86_64":
        return CpuArchitecture.x86_64;
      case "AMD64":
        return CpuArchitecture.x86_64;
      default:
        return CpuArchitecture.unknown;
    }
  }
}
