class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230722"
    checksums = {
        "darwin_arm64" => "7b13bc74f251a93ecaf308d21e42e7e410b2aafd01622eff3956953c33909f55",
        "darwin_amd64" => "b6a7e030a227e3c2b010b2f18fbe7ac811021b11e803fe743acfada9b5aedeb5",
        "linux_arm64"  => "26664d4829f885bdfe37ddd26da3f57730462dca7f1f74438b497ff2dbf922a6",
        "linux_amd64"  => "75896d574840272214c74828fe421fb7b0e8ab01dc12067151dff355f90c2e9c",
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
