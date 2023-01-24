class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230124"
    checksums = {
        "darwin_arm64" => "88c969a1442a9feb374da7c518e7b061aeb19fe48293e2b4fd4ed73fd7e0966e",
        "darwin_amd64" => "77506700ae6821073157854d48cc9e7bcf7dd5f57f755a6e6ed48e0dac491204",
        "linux_arm64"  => "77653bc73768b0c42d40dc7b853ba86a1303e898f5d3ffde84cc9f2ac7a07641",
        "linux_amd64"  => "3c514bb5a4d909cedca02f34ce83924bbf6234021c214953b3a8c160d93ad3a9",
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
