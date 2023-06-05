class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.20.1"
    checksums = {
        "darwin_arm64" => "159aef18c0c39999de2b503b979b0467ba3397d6558235e93755b7463841c3f4",
        "darwin_amd64" => "801db92551486eabdb752708bb4e2020e6150ad0c37c39683397430421f7b41e",
        "linux_arm64"  => "726780e865fbef7bd87f35ebb84d5e4a96180ae5f923966a64b0f23306c1e3d4",
        "linux_amd64"  => "4e2df663583325a4020a73d7202a2d3e4ee3e3d0ab69efaca75d54929d733f69",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]
        bin.install_symlink Dir[libexec/"bin/*"]

        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
