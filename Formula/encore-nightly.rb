class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221112"
    checksums = {
        "darwin_arm64" => "51e17c9a36811a06e957c043f3ac8917ea9acbb63b7ee093518dd4510c4e6e36",
        "darwin_amd64" => "a71c92021e00b9944bb77fbb9659f7732a4bec755770b9609b50a41c2c8d479c",
        "linux_arm64"  => "bbf3a07e713bb89d3f1e36d22623b78db5890974e0708d403665bff069a1ba44",
        "linux_amd64"  => "bc5ef9e2bcfb4cfa85f4254b658ad942457641a897ad7e4df76f95d9c5cc1c18",
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
