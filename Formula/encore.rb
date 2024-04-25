class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.36.3"
    checksums = {
        "darwin_arm64" => "87518bdad243a372302c489ada2fe506726468c3b2389c4f5db3473ff3822f7e",
        "darwin_amd64" => "1b8287efdba57631d2446a2b341a6f44a6b3d220105f97a9a34dab49112ebe81",
        "linux_arm64"  => "fe380c2811217df536ff3dc153b27e02cb0274bdfb49f8df480a577f525ee655",
        "linux_amd64"  => "fbb18b2d3e35839786658dfb0207a0d626d17509b5624aa36e6d016acc98d179",
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
