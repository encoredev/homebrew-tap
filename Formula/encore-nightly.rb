class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230314"
    checksums = {
        "darwin_arm64" => "d60cae3cf6afd8bc5c57c906ab9124afde70e7b1f3d4552cddbd882acd29ddce",
        "darwin_amd64" => "097ece3b3ad1c8b74451ba57b0a6280d9044799bacde71ee0623e1cdc1a14272",
        "linux_arm64"  => "6d020510adac5549bde5fbe133b89ce374d1e7ff6de410d1b85471b5c55d1f8a",
        "linux_amd64"  => "086225bc0c2996430cdac6c00a8ad948c466c90cebbe7b3950084fb4b1887583",
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
