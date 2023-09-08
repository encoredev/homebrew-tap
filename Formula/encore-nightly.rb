class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230908"
    checksums = {
        "darwin_arm64" => "355d23fd9123ad82bdd6d4c549a3a9c820dd9ecc7fd6093880abf22b77b3b2f1",
        "darwin_amd64" => "19a5062565545a1c4047026d553d37707b60ea4f80a739190e1c49aeb9aa83de",
        "linux_arm64"  => "eb02850342861312499a8818b55e526d2a7ea885deeb778f3b3193893c25d250",
        "linux_amd64"  => "e50bd79adc28370f6a87b719dcd2048955c70ec612d331f9335393673ee8c9ea",
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
