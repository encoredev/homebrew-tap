class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.44.5"
    checksums = {
        "darwin_arm64" => "f8e6af6903df2eec85fba75a502ea00576d2740e8fbd63556ba633f47dc9d1d1",
        "darwin_amd64" => "9500f79a2d66a8f220c1f7e4e5a8b1daceb64b9aa6c691ac0d4954e67369b9a0",
        "linux_arm64"  => "1b2bce23c5b899b78bf6a7cc877dd94f5e3e830a72027ad11da76c8d200278e4",
        "linux_amd64"  => "6fdc11821e9ba9b2112486e45bebc28f93eb9ce2ed5b98cb7249f2d40200ae31",
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
